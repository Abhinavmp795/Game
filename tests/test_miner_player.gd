## Miner player prototype test suite (addon-free).
##
## Run with:
##   godot --headless --path . -s tests/test_miner_player.gd
##
## Exit code 0 when every check passes, 1 otherwise.
## Covers the Milestone 3 definition of done:
##   - player initialization (body type, bindings, visual, camera)
##   - movement configuration (data-driven speed source)
##   - cardinal movement through the InputMap (simulated input)
##   - diagonal movement normalization (no faster diagonals)
##   - facing direction updates and persistence
##   - boundary collision and containment inside the test arena
extends SceneTree

const MINER_SCENE_PATH := "res://scenes/player/miner.tscn"
const TEST_SCENE_PATH := "res://scenes/dev/miner_test_scene.tscn"
const STATS_PATH := "res://data/heroes/miner_stats.tres"

# Expected values echo the authoritative data resource
# (res://data/heroes/miner_stats.tres) for regression safety.
const EXPECTED_BASE_SPEED := 220.0
const SPEED_EPSILON := 3.0
const POSITION_EPSILON := 3.0
const MOVE_FRAMES := 20
const ARENA_FRAMES := 240

var _passed := 0
var _failed := 0

var _facing_events: Array = []


func _initialize() -> void:
	_run_all()


func _run_all() -> void:
	await process_frame
	await process_frame

	_test_data_driven_configuration()
	await _test_miner_scene_initialization()
	await _test_cardinal_movement()
	await _test_diagonal_normalization()
	await _test_speed_is_data_driven()
	await _test_facing_direction()
	await _test_boundary_containment()

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


func _release_all_move_actions() -> void:
	for action in ["move_up", "move_down", "move_left", "move_right"]:
		Input.action_release(action)


func _spawn_miner() -> Node:
	var miner: Node = load(MINER_SCENE_PATH).instantiate()
	root.add_child(miner)
	await physics_frame
	await physics_frame
	return miner


func _spawn_test_scene() -> Node:
	var arena: Node = load(TEST_SCENE_PATH).instantiate()
	root.add_child(arena)
	await physics_frame
	await physics_frame
	return arena


func _teardown_node(node: Node) -> void:
	_release_all_move_actions()
	node.queue_free()
	await physics_frame
	await physics_frame


func _step_physics(frames: int) -> void:
	for i in frames:
		await physics_frame


func _test_data_driven_configuration() -> void:
	_check(ResourceLoader.exists(MINER_SCENE_PATH, "PackedScene"),
		"miner player scene exists: " + MINER_SCENE_PATH)
	_check(ResourceLoader.exists(TEST_SCENE_PATH, "PackedScene"),
		"miner test scene exists: " + TEST_SCENE_PATH)

	var stats = load(STATS_PATH)
	_check(stats != null, "Miner HeroStats resource loads")
	if stats == null:
		return
	_check(stats.display_name == "Miner", "stats display_name is Miner")
	_check(stats.base_move_speed == EXPECTED_BASE_SPEED,
		"stats base_move_speed matches the balance baseline (220)")
	_check(stats.move_speed_multiplier == 1.0,
		"stats move_speed_multiplier matches Move Speed 100 percent baseline")
	_check(stats.max_health == 100.0, "stats max_health matches BALANCE.md baseline")
	_check(stats.attack == 10.0, "stats attack matches BALANCE.md baseline")
	_check(stats.defense == 5.0, "stats defense matches BALANCE.md baseline")


func _test_miner_scene_initialization() -> void:
	var miner := await _spawn_miner()

	_check(miner is CharacterBody2D, "player root is a CharacterBody2D")
	_check(miner.motion_mode == CharacterBody2D.MOTION_MODE_FLOATING,
		"player body uses floating motion mode (top-down)")
	_check(miner.hero_stats != null, "HeroStats resource is bound to the player")
	if miner.hero_stats != null:
		_check(miner.hero_stats.display_name == "Miner",
			"scene injects the Miner stats resource")
	_check(is_instance_valid(miner.visual_root), "visual root is bound to the player")
	_check(miner.facing == 1, "player starts facing right")
	_check(miner.visual_root.scale.x == 1, "visual starts unflipped")

	var collision_shape: Node = miner.get_node_or_null(NodePath("CollisionShape2D"))
	_check(collision_shape != null and collision_shape.shape != null,
		"player has a collision shape")

	var camera: Node = miner.get_node_or_null(NodePath("Camera2D"))
	_check(camera is Camera2D, "player carries a Camera2D")
	if camera is Camera2D:
		_check(camera.is_current(), "player camera is the active camera")

	var initial_position: Vector2 = miner.position
	await _step_physics(MOVE_FRAMES)
	_check(miner.position.distance_to(initial_position) <= 0.01,
		"player stays still with no input (drift free)")

	await _teardown_node(miner)


func _test_cardinal_movement() -> void:
	var cases := [
		{"action": "move_left", "sign": -1.0, "axis": "x"},
		{"action": "move_right", "sign": 1.0, "axis": "x"},
		{"action": "move_up", "sign": -1.0, "axis": "y"},
		{"action": "move_down", "sign": 1.0, "axis": "y"},
	]
	for move_case in cases:
		var miner := await _spawn_miner()
		var start: Vector2 = miner.position

		Input.action_press(move_case.action)
		await _step_physics(1)
		_check(absf(miner.velocity.length() - EXPECTED_BASE_SPEED) <= SPEED_EPSILON,
			"speed equals base_move_speed while pressing %s" % move_case.action)
		await _step_physics(MOVE_FRAMES - 1)
		Input.action_release(move_case.action)

		var delta: Vector2 = miner.position - start
		var axis_delta: float = delta[move_case.axis]
		_check(axis_delta * move_case.sign > 40.0,
			"player moved along %s while pressing %s" % [move_case.axis, move_case.action])
		var other_delta: float = delta["y" if move_case.axis == "x" else "x"]
		_check(absf(other_delta) <= POSITION_EPSILON,
			"no drift on the other axis while pressing %s" % move_case.action)

		await _teardown_node(miner)


func _test_diagonal_normalization() -> void:
	var miner := await _spawn_miner()
	var start: Vector2 = miner.position

	Input.action_press("move_up")
	Input.action_press("move_right")
	await _step_physics(1)
	var speed_length: float = miner.velocity.length()
	_check(absf(speed_length - EXPECTED_BASE_SPEED) <= SPEED_EPSILON,
		"diagonal speed equals cardinal speed (normalized, ~220 not ~311)")
	# Screen-space Y is inverted (up = negative), so compare magnitudes.
	_check(absf(absf(miner.velocity.x) - absf(miner.velocity.y)) <= 0.5,
		"diagonal velocity components are equal (perfect 45 degrees)")

	await _step_physics(MOVE_FRAMES - 1)
	Input.action_release("move_up")
	Input.action_release("move_right")

	var delta: Vector2 = miner.position - start
	_check(absf(absf(delta.x) - absf(delta.y)) <= 1.5,
		"diagonal position delta is identical on both axes")
	_check(absf(delta.x) < MOVE_FRAMES * 4.0,
		"each diagonal axis travels less than a cardinal axis per frame budget")

	await _teardown_node(miner)


func _test_speed_is_data_driven() -> void:
	var miner := await _spawn_miner()
	# Mutating the bound HeroStats instance must change real movement:
	# the value lives in data, not in code. Restored afterwards.
	miner.hero_stats.move_speed_multiplier = 2.0

	Input.action_press("move_right")
	await _step_physics(1)
	_check(absf(miner.velocity.length() - EXPECTED_BASE_SPEED * 2.0) <= SPEED_EPSILON,
		"changing the stats multiplier changes movement speed (data drives gameplay)")
	Input.action_release("move_right")

	miner.hero_stats.move_speed_multiplier = 1.0
	await _teardown_node(miner)


func _test_facing_direction() -> void:
	var miner := await _spawn_miner()
	_facing_events = []
	miner.facing_changed.connect(func(value: int) -> void:
		_facing_events.append(value))

	Input.action_press("move_right")
	await _step_physics(3)
	Input.action_release("move_right")
	_check(miner.facing == 1, "facing stays right when moving right")
	_check(miner.visual_root.scale.x == 1, "visual faces right while moving right")

	Input.action_press("move_left")
	await _step_physics(3)
	Input.action_release("move_left")
	_check(miner.facing == -1, "facing flips left when moving left")
	_check(miner.visual_root.scale.x == -1, "visual flips left when moving left")

	Input.action_press("move_up")
	await _step_physics(3)
	Input.action_release("move_up")
	_check(miner.facing == -1, "vertical input keeps the last horizontal facing")

	_check(_facing_events.size() == 1 and _facing_events[0] == -1,
		"facing_changed emitted exactly once for the single flip")

	await _teardown_node(miner)


func _test_boundary_containment() -> void:
	var arena := await _spawn_test_scene()
	var miner: Node = arena.get_node_or_null(NodePath("Miner"))
	_check(miner != null, "test arena contains the Miner instance")
	if miner == null:
		await _teardown_node(arena)
		return

	var start: Vector2 = miner.position

	# Push hard into the right wall (body half width 12 -> expected stop ~1588).
	Input.action_press("move_right")
	await _step_physics(ARENA_FRAMES)
	Input.action_release("move_right")
	_check(miner.position.x > 1500.0 and miner.position.x <= 1600.0,
		"player is stopped by the right wall and stays inside the arena")
	_check(absf(miner.position.y - start.y) <= POSITION_EPSILON,
		"vertical position unchanged during the right wall push")

	# Push hard into the top wall (body half height 16 -> expected stop ~16).
	Input.action_press("move_up")
	await _step_physics(ARENA_FRAMES)
	Input.action_release("move_up")
	_check(miner.position.y >= 0.0 and miner.position.y <= 40.0,
		"player is stopped by the top wall and stays inside the arena")

	_check(miner.position.x >= 0.0 and miner.position.x <= 1600.0,
		"player x remains inside the bounded environment")
	_check(miner.position.y >= 0.0 and miner.position.y <= 900.0,
		"player y remains inside the bounded environment")

	await _teardown_node(arena)
