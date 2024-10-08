class_name ShootingManager
extends Node

@export var enabled: bool = true
@export var allow_miss: bool = true
@export var blood_particles: PackedScene
@export var shoot_sound: SoundEffect
@export var lever_sound_begin: SoundEffect
@export var lever_sound_end: SoundEffect

var can_shoot: bool = true


func _ready() -> void:
	PlayerCursor.on_primary_pressed.connect(shoot)


func set_enabled(new_value: bool) -> void:
	enabled = new_value


func shoot() -> void:
	if !enabled: return
	if !can_shoot: return
	
	var critters := Utils.get_critters_at_point(get_tree().root.get_mouse_position())
	var did_hit := false
	for critter in critters:
		if critter and critter.is_alive:
			did_hit = true
			var angle := randf_range(-60, -120)
			var offset := Vector2.from_angle(deg_to_rad(angle)) * 24
			# The particles looks better with the offset. Probably because of the knockback. Idk.
			var target_pos := critter.global_position + offset
			Effects.create_effect(blood_particles, target_pos, deg_to_rad(angle))
			Effects.create_effect(blood_particles, target_pos, deg_to_rad(angle + 180))
			critter.kill()
			critter.knock_back(randf_range(120, 180), deg_to_rad(angle))
	
	if allow_miss or (!allow_miss and did_hit):
		SoundManager.play_sound_effect(shoot_sound)
		Effects.screen_flash(PicoColors.COLOR_LIGHT_GREY, true, 0.1)
		lever_action()


func lever_action() -> void:
	can_shoot = false
	await get_tree().create_timer(0.5).timeout
	SoundManager.play_sound_effect(lever_sound_begin)
	await get_tree().create_timer(0.25).timeout
	SoundManager.play_sound_effect(lever_sound_end)
	await get_tree().create_timer(0.15).timeout
	can_shoot = true
