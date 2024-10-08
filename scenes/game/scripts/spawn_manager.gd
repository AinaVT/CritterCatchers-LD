extends Node

@export var critter_scene: PackedScene

var _difficulty: float = 0.0

func _ready() -> void:
	EventBus.second_passed.connect(_on_second_passed)
	_spawn.call_deferred()


func _spawn() -> void:
	var critter := critter_scene.instantiate() as Critter
	if critter:
		var rect := get_viewport().get_visible_rect()
		var center := rect.get_center()
		var angle := randf_range(0, 2*PI)
		critter.position = center + (Vector2.from_angle(angle) * (rect.size.x + 16))
		owner.add_child(critter)
	
	await get_tree().create_timer(randf_range(1, 5 - (3.5 * _difficulty))).timeout
	_spawn.call_deferred()


func _on_second_passed(time_left: float) -> void:
	_difficulty += 0.0075
	if time_left > 15.0:
		_difficulty = clamp(_difficulty, 0.0, 1.0)
	else:
		_difficulty += 0.075
