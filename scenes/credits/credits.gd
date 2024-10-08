extends Control


func _on_button_pressed() -> void:
	Config.has_played = true
	Config.save()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
