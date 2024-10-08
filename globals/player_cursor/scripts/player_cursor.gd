extends Node2D

signal on_primary_pressed
signal on_primary_released
signal on_secondary_pressed
signal on_secondary_released

enum CursorType {
	HAND,
	CROSSHAIR
}

@export var type: CursorType = CursorType.CROSSHAIR:
	set(value):
		type = value
		_update_cursor_visual.call_deferred()

@export var hand_sprite: SpriteFrames
@export var crosshair_sprite: SpriteFrames

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_action"):
		on_primary_pressed.emit()
	elif event.is_action_pressed("secondary_action"):
		on_secondary_pressed.emit()
	elif event.is_action_released("primary_action"):
		on_primary_released.emit()
	elif event.is_action_released("secondary_action"):
		on_secondary_released.emit()
	
	# animations
	if event.is_action_pressed("primary_action") or event.is_action_pressed("secondary_action"):
		if sprite.sprite_frames.has_animation("Pressed"):
			sprite.play("Pressed")
	elif event.is_action_released("primary_action") or event.is_action_released("secondary_action"):
		if sprite.sprite_frames.has_animation("Normal"):
			sprite.play("Normal")


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if get_index() < get_parent().get_child_count() - 1:
		get_parent().move_child(self, get_parent().get_child_count() - 1)


func _update_cursor_visual() -> void:
	match type:
		CursorType.HAND:
			sprite.sprite_frames = hand_sprite
		CursorType.CROSSHAIR:
			sprite.sprite_frames = crosshair_sprite
