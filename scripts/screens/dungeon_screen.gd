## Bootstrap shell for the DUNGEON state.
##
## Only the run-end seam exists (victory/defeat return to the hub). No
## combat, enemies, loot, generation, or bosses - those come from their
## own dedicated systems in later milestones.
extends Control


func _ready() -> void:
	$FlowBox/StateLabel.text = GameManager.state_name(GameManager.state)
	$FlowBox/VictoryButton.pressed.connect(GameManager.end_current_run.bind(true))
	$FlowBox/AbandonButton.pressed.connect(GameManager.end_current_run.bind(false))
