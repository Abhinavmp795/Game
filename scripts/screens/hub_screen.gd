## Bootstrap shell for the HUB state (persistent home concept).
##
## Wires hub navigation into GameManager only. No buildings, NPCs, or
## economy yet - those arrive with their own systems.
extends Control


func _ready() -> void:
	$FlowBox/StateLabel.text = GameManager.state_name(GameManager.state)
	$FlowBox/EnterDungeonButton.pressed.connect(GameManager.start_dungeon_run)
	$FlowBox/MainMenuButton.pressed.connect(GameManager.show_main_menu)
