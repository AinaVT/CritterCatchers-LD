extends Node2D

@export var tutorial_bunny: PackedScene

@onready var tutorial_spawn: Node2D = $TutorialBunnySpawn
@onready var sleeping_area: Area2D = $BunnySleepingArea
@onready var lanius: LaniusTutorial = $LaniusTutorial


func _ready() -> void:
	PlayerCursor.type = PlayerCursor.CursorType.HAND


func spawn_tutorial_bunny() -> void:
	var bunny := tutorial_bunny.instantiate() as BunnyTutorial
	bunny.global_position = tutorial_spawn.global_position
	bunny.velocity = Vector2.from_angle(tutorial_spawn.get_angle_to(sleeping_area.global_position)) * 64
	bunny.began_sleeping.connect(_on_bunny_began_sleeping)
	bunny.died.connect(_on_bunny_died)
	add_child(bunny)


func _on_bunny_began_sleeping() -> void:
	lanius.on_bunny_slept()


func _on_bunny_died() -> void:
	$TileMapLayer.queue_free()
	$AudioStreamPlayer.stop()
	PlayerCursor.type = PlayerCursor.CursorType.CROSSHAIR
	lanius.on_bunny_died()
