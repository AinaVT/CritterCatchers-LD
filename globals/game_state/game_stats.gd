extends Node

signal kill_count_increased
signal caught_count_increased
signal escaped_count_increased

var killed_critters: int = 0
var caught_critters: int = 0
var escaped_critters: int = 0


func _ready() -> void:
	EventBus.critter_killed.connect(_on_critter_killed)
	EventBus.critter_caught.connect(_on_critter_caught)
	EventBus.critter_escaped.connect(_on_critter_escaped)


func _on_critter_killed() -> void:
	killed_critters += 1
	kill_count_increased.emit()


func _on_critter_caught() -> void:
	caught_critters += 1
	caught_count_increased.emit()


func _on_critter_escaped() -> void:
	escaped_critters += 1
	escaped_count_increased.emit()


func reset_game_stats() -> void:
	killed_critters = 0
	caught_critters = 0
	escaped_critters = 0
