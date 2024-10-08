extends Critter

@export var gravity: float = 9.8
@export var hop_power: float = 10
@export var hop_sound: SoundEffect
@export var hurt_sound: SoundEffect

@onready var sprite: AnimatedSprite2D = $Body/AnimatedSprite2D
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var body: Node2D = $Body

var z_vel := 0.0
var z_pos := randf_range(-32, 0)


func _process(delta: float) -> void:
	super._process(delta)
	if is_alive and !velocity.is_zero_approx():
		_hop_if_possible()
		sprite.flip_h = velocity.x >= 0
	
	z_vel += gravity * delta
	z_pos += z_vel * delta
	
	if z_pos > 0.0:
		z_vel = 0.0
		z_pos = 0.0
	
	body.position.y = z_pos
	
	if is_dead:
		var size := sprite.sprite_frames.get_frame_texture("Alive", 0).get_size()
		position = position.clamp(size / 2.0, get_viewport_rect().size - (size / 2.0))


func _hop_if_possible() -> void:
	if is_dead: return
	
	if is_zero_approx(z_pos):
		z_vel = -hop_power
		if screen_notifier.is_on_screen():
			SoundManager.play_sound_effect(hop_sound)


func _on_died() -> void:
	z_vel = 15
	sprite.play("Dead")
	SoundManager.play_sound_effect(hurt_sound)


func _on_visible_on_screen_exited() -> void:
	EventBus.critter_escaped.emit()
	queue_free()
