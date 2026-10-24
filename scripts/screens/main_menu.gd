## Bootstrap shell for the MAIN_MENU state.
##
## Flow shell only: binds menu navigation into GameManager. No gameplay,
## no assets, no combat - visual design happens in a dedicated UI milestone.
extends Control


func _ready() -> void:
	$FlowBox/StateLabel.text = GameManager.state_name(GameManager.state)
	$FlowBox/EnterHubButton.pressed.connect(GameManager.enter_hub)
