extends Control

const CHAR_SELECTOR_SCENE := preload("res://scenes/ui/character_selector.tscn")

@onready var continue_button: Button = %Continue
@export var music: AudioStream

func _ready() -> void:
	MusicPlayer.play(music, true)
	get_tree().paused = false

func _on_continue_pressed() -> void:
	MusicPlayer.stop()
	print("继续运行")


func _on_new_run_pressed() -> void:
	MusicPlayer.stop()
	get_tree().change_scene_to_packed(CHAR_SELECTOR_SCENE)


func _on_exit_pressed() -> void:
	MusicPlayer.stop()
	get_tree().quit()
