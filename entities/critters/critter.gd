class_name Critter
extends Node2D

signal died

var is_dead := false
var is_alive: bool:
	get: return !is_dead

var velocity: Vector2 = Vector2.ZERO
var knock_back_vel: Vector2 = Vector2.ZERO


func knock_back(amount: float, direction: float) -> void:
	knock_back_vel = Vector2.from_angle(direction) * amount


func _ready() -> void:
	_move_random.call_deferred()


func _process(delta: float) -> void:
	position += knock_back_vel * delta
	knock_back_vel = knock_back_vel.move_toward(Vector2.ZERO, 300 * delta)
	
	if is_alive:
		position += velocity * delta


func _move_random() -> void:
	var center := get_viewport_rect().get_center()
	var angle := randf_range(0, 2*PI)
	var distance := randf_range(0, 64)
	var target := center + Vector2.from_angle(angle).normalized() * distance
	
	velocity = Vector2.from_angle(get_angle_to(target)).normalized() * randf_range(64, 128)


func kill() -> void:
	is_dead = true
	died.emit()
	EventBus.critter_killed.emit()
