class_name Lanius
extends Node2D

@export var lanius_sound: SoundEffect

@onready var dialogue_label: Label = %DialogueLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mouse_icon: AnimatedSprite2D = %MouseIcon

var last_visible_characters: int = 0


func timer(duration: float) -> void:
	await get_tree().create_timer(duration).timeout


func say(text: String, time_per_char: float = 0.065) -> void:
	clear_dialogue()
	dialogue_label.text = text
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	await tween.tween_property(dialogue_label, "visible_characters", text.length(), time_per_char * text.length()).finished


func clear_dialogue() -> void:
	dialogue_label.text = ""
	dialogue_label.visible_characters = 0


func cursor_prompt() -> void:
	mouse_icon.visible = true
	await PlayerCursor.on_primary_pressed
	mouse_icon.visible = false


func _process(delta: float) -> void:
	if dialogue_label.text.length() > 0 and dialogue_label.visible_characters > last_visible_characters:
		if dialogue_label.text[dialogue_label.visible_characters - 1] != " ":
			SoundManager.play_sound_effect(lanius_sound)
	
	last_visible_characters = dialogue_label.visible_characters
