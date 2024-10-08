class_name WrappingManager
extends Node

signal critter_wrapped

@export var enabled: bool = true
@export var wrapping_time: float = 1.0
@export var wrapping_sound: SoundEffect
@export var catch_sound: SoundEffect
@export var bag_node: PackedScene

var is_wrapping: bool = false
var wrapping_timer: float = 0.0
var wrapped_critter: Critter = null


func _ready() -> void:
	PlayerCursor.on_secondary_pressed.connect(_on_secondary_pressed)
	PlayerCursor.on_secondary_released.connect(_on_secondary_Released)


func set_enabled(new_value: bool) -> void:
	enabled = new_value


func _on_secondary_pressed() -> void:
	var critter := Utils.get_critter_at_point(get_tree().root.get_mouse_position())
	if !critter: return
	
	if critter.is_dead:
		start_wrapping_critter(critter)


func _on_secondary_Released() -> void:
	stop_wrapping()


func start_wrapping_critter(critter: Critter) -> void:
	if !enabled: return
	
	is_wrapping = true
	wrapping_timer = 0.0
	wrapped_critter = critter
	SoundManager.play_sound_effect(wrapping_sound)


func stop_wrapping() -> void:
	if !enabled: return
	
	is_wrapping = false
	wrapping_timer = 0.0
	wrapped_critter = null
	SoundManager.stop_sound_effect(wrapping_sound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_wrapping:
		wrapping_timer += delta
		if wrapping_timer >= wrapping_time:
			var critter_pos := wrapped_critter.global_position
			wrapped_critter.queue_free()
			Effects.create_effect(bag_node, critter_pos, 0)
			FloatingTextManager.create_text("CAUGHT!!", critter_pos + Vector2(0, -20))
			SoundManager.play_sound_effect(catch_sound)
			stop_wrapping()
			critter_wrapped.emit()
			EventBus.critter_caught.emit()
