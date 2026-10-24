## GameManager - WHAT the game is doing.
##
## Flow authority (ARCHITECTURE.md spirit, sections 3.1/3.2/22):
##   - owns the high-level game state and the legal flow seams
##   - holds the data-driven state -> screen registry (single source of
##     truth; future screens are added by editing SCENE_PATHS, no rewrite)
##   - delegates all loading/swapping to SceneManager (HOW)
##
## Deliberately knows nothing about gameplay content (combat, dungeon
## generation, saves). Other systems integrate by observing signals, not
## by calling UI or mutating other systems directly.
extends Node

## A flow seam changed; observers (UI, future systems) react without coupling.
signal state_changed(previous_state: int, new_state: int)
## A dungeon run was entered (the dungeon screen is now active).
signal run_started()
## A dungeon run ended (victory or defeat); rewards will be banked later.
signal run_ended(won: bool)

enum GameState {
	UNKNOWN,
	MAIN_MENU,
	HUB,
	DUNGEON,
}

## Data-driven state -> screen registry. Keep paths relative to res://.
const SCENE_PATHS: Dictionary = {
	GameState.MAIN_MENU: "res://scenes/main_menu.tscn",
	GameState.HUB: "res://scenes/hub.tscn",
	GameState.DUNGEON: "res://scenes/dungeon.tscn",
}

var state: int = GameState.UNKNOWN

## Test seam: an injected scene-manager stand-in takes precedence over the
## project autoload, which is resolved by node path only at transition time
## (never at parse time, keeping the script standalone-testable).
var _scene_manager_override: Node = null


## Replaces the scene-manager dependency (used by the automated tests).
func set_scene_manager_override(manager: Node) -> void:
	_scene_manager_override = manager


## Application entry point: moves into the main menu when no flow started
## yet. Idempotent; safe to call from the Main shell at boot.
func boot() -> void:
	if state == GameState.UNKNOWN:
		_transition_to(GameState.MAIN_MENU)


func show_main_menu() -> bool:
	return _transition_to(GameState.MAIN_MENU)


func enter_hub() -> bool:
	return _transition_to(GameState.HUB)


func start_dungeon_run() -> bool:
	var accepted := _transition_to(GameState.DUNGEON)
	if accepted:
		run_started.emit()
	return accepted


## Ends the active dungeon run and returns to the hub. Only valid while a
## run is active (rejects invalid flow seams from UI mistakes early).
func end_current_run(won: bool) -> bool:
	if state != GameState.DUNGEON:
		push_warning("GameManager: end_current_run ignored (state is %s, not DUNGEON)." % state_name(state))
		return false
	var accepted := _transition_to(GameState.HUB)
	if accepted:
		run_ended.emit(won)
	return accepted


## Human-readable state label (used by shell screens and the tests).
func state_name(requested_state: int) -> String:
	match requested_state:
		GameState.UNKNOWN:
			return "UNKNOWN"
		GameState.MAIN_MENU:
			return "MAIN_MENU"
		GameState.HUB:
			return "HUB"
		GameState.DUNGEON:
			return "DUNGEON"
	return "INVALID(%d)" % requested_state


func _transition_to(new_state: int) -> bool:
	var previous := state
	var scene_path: String = SCENE_PATHS.get(new_state, "")
	if scene_path.is_empty():
		push_error("GameManager: no screen is registered for state %s." % state_name(new_state))
		return false

	var scene_manager := _resolve_scene_manager()
	if scene_manager == null or not scene_manager.has_method("goto_scene"):
		push_error("GameManager: SceneManager is unavailable; cannot open %s." % scene_path)
		return false

	if not scene_manager.goto_scene(scene_path):
		return false

	state = new_state
	state_changed.emit(previous, new_state)
	return true


func _resolve_scene_manager() -> Node:
	if is_instance_valid(_scene_manager_override):
		return _scene_manager_override
	return get_node_or_null(NodePath("/root/SceneManager"))
