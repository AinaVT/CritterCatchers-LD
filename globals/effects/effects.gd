extends Node


func freeze_frame(duration: float, time_scale: float = 0.1) -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0


func screen_flash(color: Color = PicoColors.COLOR_WHITE, fade_out: bool = false, duration: float = 0.05) -> void:
	var flash := ColorRect.new()
	flash.color = color
	flash.z_index = 10
	flash.set_anchors_preset(Control.PRESET_FULL_RECT)
	get_tree().root.add_child(flash)
	if fade_out:
		var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
		await tween.tween_property(flash, "color", Color(color, 0.0), duration).finished
	else:
		await get_tree().create_timer(duration).timeout
	flash.queue_free()


func create_effect(effect_scene: PackedScene, position: Vector2, rotation: float) -> void:
	if !effect_scene: return
	
	var effect := effect_scene.instantiate() as Node2D
	if !effect: return
	
	effect.global_position = position
	effect.global_rotation = rotation
	
	get_tree().current_scene.add_child(effect)
