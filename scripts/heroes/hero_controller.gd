class_name HeroController
extends CharacterBody2D

## Miner player prototype controller (Milestone 3).
##
## Scope: movement + facing only, driven by the project InputMap actions
## (move_left/move_right/move_up/move_down) through proper
## CharacterBody2D physics processing.
##
## Architecture preparation (ARCHITECTURE.md section 6, composition):
## future components (attack, dash, skills, health, status effects,
## equipment, progression) will attach as sibling child nodes/exports of
## the player scene and must consume the same HeroStats resource instead
## of declaring their own balance values.
##
## The controller never hard-codes balance values: if no HeroStats
## resource is bound it reports an error and refuses to move, so a
## missing data binding can never silently tune gameplay.

## Emitted whenever the sprite facing flips (visualization + future
## attack/skill aim hooks can observe this).
signal facing_changed(facing: int)

const MOVE_LEFT_ACTION := "move_left"
const MOVE_RIGHT_ACTION := "move_right"
const MOVE_UP_ACTION := "move_up"
const MOVE_DOWN_ACTION := "move_down"

## Data-driven baseline values injected from res://data/heroes/*.tres.
@export var hero_stats: HeroStats

## Direct node binding for the visual root (assigned in the editor).
## Hand-authored scenes may leave this empty and bind via
## visual_root_path instead; the controller resolves it automatically.
@export var visual_root: Node2D

## NodePath of the visual root inside the player scene, resolved in
## _ready when the direct binding above is empty.
@export var visual_root_path: NodePath = NodePath("PlaceholderVisual")

## Sprite facing: +1 = right, -1 = left. Kept on vertical input so the
## character keeps its last horizontal orientation.
var facing: int = 1

## Last non-zero input direction (normalized). Future systems use this
## as aim/dash/skill direction.
var last_move_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	if hero_stats == null:
		push_error("%s: no HeroStats resource bound; movement is disabled." % name)
	if visual_root == null and not visual_root_path.is_empty():
		visual_root = get_node_or_null(visual_root_path) as Node2D
	if visual_root == null:
		push_error("%s: no visual_root bound; facing flip is disabled." % name)
	else:
		_apply_visual_facing()


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector(
		MOVE_LEFT_ACTION,
		MOVE_RIGHT_ACTION,
		MOVE_UP_ACTION,
		MOVE_DOWN_ACTION
	)

	velocity = input_direction * _final_move_speed()
	move_and_slide()
	_update_facing(input_direction)


## Single gameplay source of truth for speed: the bound HeroStats
## resource. Returns 0 (and an error) when the data binding is missing
## so gameplay can never accidentally fall into a duplicated constant.
func _final_move_speed() -> float:
	if hero_stats == null:
		return 0.0
	return hero_stats.base_move_speed * hero_stats.move_speed_multiplier


func _update_facing(input_direction: Vector2) -> void:
	if input_direction.is_zero_approx():
		return
	last_move_direction = input_direction.normalized()
	if input_direction.x < 0.0 and facing != -1:
		facing = -1
		_apply_visual_facing()
	elif input_direction.x > 0.0 and facing != 1:
		facing = 1
		_apply_visual_facing()


func _apply_visual_facing() -> void:
	if is_instance_valid(visual_root):
		visual_root.scale.x = facing
	facing_changed.emit(facing)
