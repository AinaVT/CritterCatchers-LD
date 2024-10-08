extends Node

const PATH := "user://config.save"

var has_played: bool = false:
	set(value):
		has_played = value
		save()


func _ready() -> void:
	var file := FileAccess.open(PATH, FileAccess.READ)
	if !file: return
	
	has_played = file.get_var()
	print(has_played)


func save() -> void:
	var file := FileAccess.open(PATH, FileAccess.WRITE)
	file.store_var(has_played)
	file.close()
