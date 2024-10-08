class_name FloatingText
extends Node2D

@onready var label := $LabelAnchor/Label

func set_text(text: String) -> void:
	if !is_node_ready(): await ready
	label.text = text

func set_amount(damage: int) -> void:
	await ready
	label.text = str(damage)
