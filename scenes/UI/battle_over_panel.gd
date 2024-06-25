class_name BattleOverPanel
extends Panel

enum Type {WIN, LOSE}

@onready var label: Label = %Label
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	continue_button.pressed.connect(
		#func(): Events.battle_won.emit()
		_on_continue_button_pressed
	)
	restart_button.pressed.connect(
		#get_tree().reload_current_scene
		_on_restart_button_pressed
	)
	Events.battle_over_screen_requested.connect(show_screen)
	
func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	
func _on_continue_button_pressed() -> void:
	Events.battle_won.emit()
	
func show_screen(text: String, type: Type) -> void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true
