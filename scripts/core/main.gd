## Main - persistent application shell (ARCHITECTURE.md section 5).
##
## SceneRoot is the swap container managed by the SceneManager autoload.
## UILayer is reserved for the future global UI (HUD shell, pause overlay).
## The transition overlay is owned by SceneManager itself (autoload node).
## Game flow starts here because this is the first project scene that exists.
extends Node


func _ready() -> void:
	SceneManager.register_scene_root($SceneRoot)
	GameManager.boot()
