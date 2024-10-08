extends Node

@export var round_time: float = 60 * 2

@onready var time_left: float = round_time
@onready var last_integer_second: float = floor(round_time)


func _process(delta: float) -> void:
	time_left -= delta
	if last_integer_second != floor(time_left):
		last_integer_second = floor(time_left)
		EventBus.second_passed.emit(time_left)
