extends Node

@export var end_cutscene_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.second_passed.connect(_on_second_passed)
	GameStats.reset_game_stats()
	PlayerCursor.type = PlayerCursor.CursorType.CROSSHAIR


func _on_second_passed(time_left: float) -> void:
	if time_left <= 0.0:
		SoundManager.stop_all_sounds()
		Transitioner.transition_scene(end_cutscene_scene, 0.0)
