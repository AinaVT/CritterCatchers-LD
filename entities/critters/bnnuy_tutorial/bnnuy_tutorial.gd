class_name BunnyTutorial
extends "res://entities/critters/bnnuy/scripts/bnnuy.gd"

signal began_sleeping


func _ready() -> void:
	pass


func _on_sleeping_detector_area_entered(area: Area2D) -> void:
	#global_position = area.global_position
	create_tween().set_ease(Tween.EASE_OUT).tween_property(self, "global_position", area.global_position, 0.25)
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.5).timeout
	sprite.flip_h = true
	await get_tree().create_timer(0.5).timeout
	sprite.flip_h = false
	await get_tree().create_timer(1.0).timeout
	_hop_if_possible()
	await get_tree().create_timer(0.5).timeout
	sprite.play("Eepy")
	began_sleeping.emit()
