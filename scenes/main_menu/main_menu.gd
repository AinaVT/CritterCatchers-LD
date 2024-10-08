extends Control

@export var game_start_sound: SoundEffect


func _ready() -> void:
	PlayerCursor.type = PlayerCursor.CursorType.HAND


func _on_start_game_btn_pressed() -> void:
	$VBoxContainer/ButtonsContainer/StartGameBtn.disabled = true
	$VBoxContainer/ButtonsContainer/ExitBtn.disabled = true
	SoundManager.play_sound_effect(game_start_sound)
	Transitioner.transition_scene(preload("res://scenes/tutorial/tutorial.tscn"))


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
