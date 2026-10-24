## Bootstrap & scene-management test suite (addon-free).
##
## Run with:
##   godot --headless --path . -s tests/test_bootstrap.gd
##
## Exit code 0 when every check passes, 1 otherwise.
## Coverage is unit + integration level (TEST_PLAN.md sections 3/4 spirit):
##   - flow registry integrity and scene existence
##   - SceneManager validation, swap lifecycle, single-flight guard
##   - GameManager flow seams via a stubbed scene manager
##   - live autoload integration when the project singletons are loaded
extends SceneTree

var _passed := 0
var _failed := 0

# Signal collectors (script-level so GDScript lambdas share references).
var _state_seams: Array = []
var _runs_started := 0
var _runs_ended: Array = []
var _live_paths: Array = []


## Minimal SceneManager stand-in used to unit-test GameManager decisions.
class StubSceneManager extends Node:
	var requested_paths: Array = []
	var accept_calls := true

	func goto_scene(scene_path: String) -> bool:
		requested_paths.append(scene_path)
		return accept_calls


func _initialize() -> void:
	_run_all()


func _run_all() -> void:
	# Give autoloads (when present) one frame to finish _ready().
	await process_frame
	await process_frame

	_test_flow_registry_integrity()
	await _test_scene_manager_rejections()
	await _test_scene_manager_swap_lifecycle()
	await _test_game_manager_flow()
	await _test_live_autoload_integration()

	print("================================================================")
	print("TEST SUMMARY: passed=%d failed=%d" % [_passed, _failed])
	quit(1 if _failed > 0 else 0)


func _check(condition: bool, label: String) -> void:
	if condition:
		_passed += 1
		print("PASS   " + label)
	else:
		_failed += 1
		print("FAIL   " + label)


func _spawn_scene_manager() -> Node:
	var scene_manager: Node = load("res://scripts/core/scene_manager.gd").new()
	root.add_child(scene_manager)
	return scene_manager


func _spawn_scene_root(holder_name: String) -> Node:
	var holder := Node.new()
	holder.name = holder_name
	root.add_child(holder)
	return holder


func _cleanup_pair(scene_manager: Node, holder: Node) -> void:
	holder.queue_free()
	scene_manager.queue_free()
	await process_frame
	await process_frame


func _test_flow_registry_integrity() -> void:
	var game_manager_script := load("res://scripts/core/game_manager.gd")
	_check(game_manager_script != null, "game_manager.gd loads")
	if game_manager_script == null:
		return

	var probe = game_manager_script.new()
	_check(probe.state == probe.GameState.UNKNOWN, "fresh GameManager state is UNKNOWN")

	var mapped_states: Array = []
	for state_key in probe.SCENE_PATHS:
		mapped_states.append(state_key)
	mapped_states.sort()
	var expected_states: Array = [
		probe.GameState.MAIN_MENU,
		probe.GameState.HUB,
		probe.GameState.DUNGEON,
	]
	expected_states.sort()
	_check(mapped_states == expected_states,
		"SCENE_PATHS covers exactly all non-UNKNOWN states")

	var all_paths_valid := true
	for scene_path: String in probe.SCENE_PATHS.values():
		if scene_path.is_empty() or not ResourceLoader.exists(scene_path, "PackedScene"):
			all_paths_valid = false
	_check(all_paths_valid, "every registered flow scene exists on disk")
	probe.free()

	for shell_scene in [
		"res://scenes/main.tscn",
		"res://scenes/main_menu.tscn",
		"res://scenes/hub.tscn",
		"res://scenes/dungeon.tscn",
	]:
		_check(ResourceLoader.exists(shell_scene, "PackedScene"),
			"project scene exists: " + str(shell_scene))


func _test_scene_manager_rejections() -> void:
	var scene_manager := _spawn_scene_manager()
	var reported_failures: Array = []
	scene_manager.scene_change_failed.connect(
		func(scene_path: String, reason: String) -> void:
			reported_failures.append(scene_path + " -- " + reason)
	)

	# (a) no scene root registered yet
	_check(not scene_manager.goto_scene("res://scenes/main_menu.tscn"),
		"goto without scene root is rejected")
	_check(reported_failures.size() == 1, "scene_change_failed emitted for missing root")

	# (b) unknown target with a registered root
	var holder := _spawn_scene_root("TestRoot_Rejections")
	_check(scene_manager.register_scene_root(holder), "scene root registration accepted")
	_check(scene_manager.get_current_scene() == null, "current scene empty before first swap")
	_check(not scene_manager.goto_scene("res://scenes/this_scene_does_not_exist.tscn"),
		"goto to missing resource is rejected")
	_check(reported_failures.size() == 2, "scene_change_failed emitted for missing resource")
	_check(scene_manager.get_current_scene() == null, "current scene untouched after rejections")

	await _cleanup_pair(scene_manager, holder)


func _test_scene_manager_swap_lifecycle() -> void:
	var scene_manager := _spawn_scene_manager()
	var holder := _spawn_scene_root("TestRoot_Swap")
	scene_manager.register_scene_root(holder)

	var started: Array = []
	var changed: Array = []
	scene_manager.scene_change_started.connect(func(scene_path: String) -> void:
		started.append(scene_path))
	scene_manager.scene_changed.connect(func(scene_path: String, _scene: Node) -> void:
		changed.append(scene_path))

	_check(scene_manager.goto_scene("res://scenes/main_menu.tscn"), "first goto accepted")
	_check(scene_manager.is_busy(), "swap is pending immediately after acceptance")
	_check(not scene_manager.goto_scene("res://scenes/hub.tscn"),
		"goto during pending swap rejected (single-flight guard)")

	await process_frame
	await process_frame

	_check(started.size() == 1, "scene_change_started emitted exactly once")
	_check(changed.size() == 1, "scene_changed emitted exactly once")
	var menu_scene: Node = scene_manager.get_current_scene()
	_check(menu_scene != null and menu_scene.name == "MainMenu", "MainMenu instance is active")
	_check(holder.get_child_count() == 1, "scene root holds exactly one screen")
	_check(scene_manager.get_current_scene_path() == "res://scenes/main_menu.tscn",
		"current scene path is tracked")
	_check(not scene_manager.is_busy(), "swap no longer pending once it landed")

	_check(scene_manager.goto_scene("res://scenes/hub.tscn"), "second goto accepted")
	await process_frame
	await process_frame

	_check(changed.size() == 2, "second scene_changed emitted")
	var hub_scene: Node = scene_manager.get_current_scene()
	_check(hub_scene != null and hub_scene.name == "Hub", "Hub instance replaced MainMenu")
	_check(holder.get_child_count() == 1, "old screen removed; no duplicate screens")

	await _cleanup_pair(scene_manager, holder)


func _test_game_manager_flow() -> void:
	var game_manager: Node = load("res://scripts/core/game_manager.gd").new()
	var stub := StubSceneManager.new()
	game_manager.set_scene_manager_override(stub)

	_state_seams = []
	_runs_started = 0
	_runs_ended = []
	game_manager.state_changed.connect(func(previous_state: int, new_state: int) -> void:
		_state_seams.append([previous_state, new_state]))
	game_manager.run_started.connect(func() -> void:
		_runs_started += 1)
	game_manager.run_ended.connect(func(won: bool) -> void:
		_runs_ended.append(won))

	_check(game_manager.state == game_manager.GameState.UNKNOWN, "unit flow starts UNKNOWN")

	game_manager.boot()
	_check(game_manager.state == game_manager.GameState.MAIN_MENU, "boot lands in MAIN_MENU")
	_check(stub.requested_paths.size() == 1
		and stub.requested_paths[0] == "res://scenes/main_menu.tscn",
		"boot routes to the menu scene path")

	_check(game_manager.enter_hub(), "enter_hub accepted")
	_check(game_manager.state == game_manager.GameState.HUB, "state seams to HUB")
	_check(game_manager.start_dungeon_run(), "dungeon run started")
	_check(game_manager.state == game_manager.GameState.DUNGEON, "state seams to DUNGEON")
	_check(_runs_started == 1, "run_started emitted exactly once")

	_check(game_manager.end_current_run(true), "run end (victory) accepted")
	_check(game_manager.state == game_manager.GameState.HUB, "run end returns to HUB")
	_check(_runs_ended.size() == 1 and _runs_ended[0] == true, "run_ended emitted won=true")

	_check(not game_manager.end_current_run(false), "run end outside a dungeon rejected")
	_check(not game_manager._transition_to(999), "unregistered state rejected")
	_check(game_manager.state == game_manager.GameState.HUB, "state unchanged after rejections")
	_check(game_manager.state_name(game_manager.state) == "HUB", "state_name reads correctly")

	var expected_seams: Array = [
		[game_manager.GameState.UNKNOWN, game_manager.GameState.MAIN_MENU],
		[game_manager.GameState.MAIN_MENU, game_manager.GameState.HUB],
		[game_manager.GameState.HUB, game_manager.GameState.DUNGEON],
		[game_manager.GameState.DUNGEON, game_manager.GameState.HUB],
	]
	_check(_state_seams == expected_seams, "state_changed seam sequence is correct")

	game_manager.free()
	stub.free()
	await process_frame


func _test_live_autoload_integration() -> void:
	var live_game_manager: Node = root.get_node_or_null(NodePath("GameManager"))
	var live_scene_manager: Node = root.get_node_or_null(NodePath("SceneManager"))
	if live_game_manager == null or live_scene_manager == null:
		print("SKIP   live autoload integration (project autoloads are not loaded under -s)")
		return

	var holder := _spawn_scene_root("TestRoot_Live")
	_check(live_scene_manager.register_scene_root(holder), "live scene root registered")
	_check(live_game_manager.state == live_game_manager.GameState.UNKNOWN,
		"live flow starts UNKNOWN (main scene is not loaded under -s)")

	var live_handler := func(scene_path: String, _scene: Node) -> void:
		_live_paths.append(scene_path)
	live_scene_manager.scene_changed.connect(live_handler)

	live_game_manager.boot()
	await process_frame
	await process_frame
	_check(live_game_manager.state == live_game_manager.GameState.MAIN_MENU,
		"live boot reaches MAIN_MENU")
	_check(_live_paths.size() == 1 and _live_paths[0] == "res://scenes/main_menu.tscn",
		"live boot loaded the menu scene through /root/SceneManager")

	live_game_manager.start_dungeon_run()
	await process_frame
	await process_frame
	_check(live_game_manager.state == live_game_manager.GameState.DUNGEON,
		"live run start reaches DUNGEON")

	live_game_manager.end_current_run(true)
	await process_frame
	await process_frame
	_check(live_game_manager.state == live_game_manager.GameState.HUB,
		"live run end returns to HUB")
	_check(_live_paths.size() == 3
		and _live_paths[1] == "res://scenes/dungeon.tscn"
		and _live_paths[2] == "res://scenes/hub.tscn",
		"live route visited the dungeon scene then the hub scene")

	var live_current: Node = live_scene_manager.get_current_scene()
	_check(live_scene_manager.get_current_scene_path() == "res://scenes/hub.tscn",
		"live scene manager tracks the hub path")
	_check(live_current != null and live_current.name == "Hub", "live hub screen is active")

	if live_scene_manager.scene_changed.is_connected(live_handler):
		live_scene_manager.scene_changed.disconnect(live_handler)
	holder.queue_free()
	await process_frame
