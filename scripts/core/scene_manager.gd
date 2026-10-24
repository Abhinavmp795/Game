## SceneManager - HOW scenes are loaded and swapped inside the persistent
## Main shell (res://scenes/main.tscn, ARCHITECTURE.md section 5).
##
## Responsibilities:
##   - validates the target resource before touching the scene tree
##   - swaps the active screen inside the registered SceneRoot container
##     (deferred, so changing scenes is safe from signal handlers and
##     button callbacks)
##   - owns the transition overlay (plain black fade; no assets required)
##   - reports outcomes exclusively through signals (ARCHITECTURE.md 2.4)
##
## Out of scope by design: deciding WHICH screen comes next (GameManager's
## job), saving state, gameplay content.
extends Node

## Raised when a transition request is accepted (before the deferred swap).
signal scene_change_started(scene_path: String)
## Raised when the new screen is instantiated and lives in the SceneRoot.
signal scene_changed(scene_path: String, scene: Node)
## Raised when a transition could not be performed; listeners can react
## (e.g. re-enable buttons) without a crash.
signal scene_change_failed(scene_path: String, reason: String)

const TRANSITION_LAYER_INDEX := 100
const TRANSITION_FADE_SECONDS := 0.15

var _scene_root: Node = null
var _current_scene: Node = null
var _current_scene_path: String = ""
var _swap_pending: bool = false
var _transition_cover: ColorRect = null


func _ready() -> void:
	_build_transition_layer()


## The persistent Main shell registers its swap container at boot.
## Returns true when the registration was accepted.
func register_scene_root(scene_root: Node) -> bool:
	if scene_root == null:
		push_error("SceneManager: cannot register a null scene root.")
		return false
	_scene_root = scene_root
	return true


## True while a requested swap has not been applied yet.
func is_busy() -> bool:
	return _swap_pending


## Currently active screen node inside the SceneRoot, or null.
func get_current_scene() -> Node:
	if is_instance_valid(_current_scene):
		return _current_scene
	return null


## Resource path of the currently active screen, or "" if none.
func get_current_scene_path() -> String:
	return _current_scene_path


## Requests a transition to a project .tscn. Validation failures never
## crash the process: they are reported via scene_change_failed.
## Returns true when the request was accepted; observe the signals for the
## outcome of the deferred swap.
func goto_scene(scene_path: String) -> bool:
	if _scene_root == null:
		_fail(scene_path, "no scene root is registered")
		return false
	if _swap_pending:
		_fail(scene_path, "another scene swap is still pending")
		return false
	if not ResourceLoader.exists(scene_path, "PackedScene"):
		_fail(scene_path, "scene resource does not exist: " + scene_path)
		return false

	var packed: PackedScene = load(scene_path)
	if packed == null:
		_fail(scene_path, "scene resource failed to load")
		return false

	_swap_pending = true
	_black_out()
	scene_change_started.emit(scene_path)
	call_deferred("_apply_swap", scene_path, packed)
	return true


func _apply_swap(scene_path: String, packed: PackedScene) -> void:
	_swap_pending = false

	var new_scene: Node = null
	if packed != null:
		new_scene = packed.instantiate()
	if new_scene == null:
		_fail(scene_path, "scene instance could not be created")
		return

	if is_instance_valid(_current_scene):
		_current_scene.queue_free()
	_scene_root.add_child(new_scene)
	_current_scene = new_scene
	_current_scene_path = scene_path
	_reveal()
	scene_changed.emit(scene_path, new_scene)


func _fail(scene_path: String, reason: String) -> void:
	_reveal()
	push_error("SceneManager: " + reason)
	scene_change_failed.emit(scene_path, reason)


## Transition overlay: an opaque black cover that hides the swap moment,
## then reveals the new screen. Lives on its own CanvasLayer so screens
## can never cover it by accident.
func _build_transition_layer() -> void:
	var layer := CanvasLayer.new()
	layer.name = "TransitionLayer"
	layer.layer = TRANSITION_LAYER_INDEX
	add_child(layer)

	_transition_cover = ColorRect.new()
	_transition_cover.name = "TransitionCover"
	_transition_cover.color = Color(0.0, 0.0, 0.0, 0.0)
	_transition_cover.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_transition_cover.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(_transition_cover)


func _black_out() -> void:
	if is_instance_valid(_transition_cover):
		_transition_cover.color = Color(0.0, 0.0, 0.0, 1.0)


func _reveal() -> void:
	if not is_instance_valid(_transition_cover):
		return
	var tween := create_tween()
	tween.tween_property(_transition_cover, "color:a", 0.0, TRANSITION_FADE_SECONDS)
