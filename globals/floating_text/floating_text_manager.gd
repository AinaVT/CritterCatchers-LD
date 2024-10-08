extends Node

@onready var floating_text_scene: PackedScene = preload("./floating_text.tscn")



func create_text(text: String, position: Vector2) -> FloatingText:
	var floating := floating_text_scene.instantiate() as FloatingText
	floating.set_text(text)
	floating.global_position = position
	get_tree().current_scene.add_child(floating)
	return floating
