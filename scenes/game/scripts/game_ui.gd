extends CanvasLayer

@export var warning_sound: SoundEffect

@onready var time_label: Label = $TimeLabel
@onready var caught_label: Label = $VBoxContainer/CaughtLabel
@onready var escaped_label: Label = $VBoxContainer/EscapedLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.second_passed.connect(_on_second_passed)
	GameStats.caught_count_increased.connect(_on_caught_count_increased)
	GameStats.escaped_count_increased.connect(_on_escaped_count_increased)


func _on_caught_count_increased() -> void:
	caught_label.text = "Caught: %s" % GameStats.caught_critters


func _on_escaped_count_increased() -> void:
	escaped_label.text = "Escaped: %s" % GameStats.escaped_critters


func _on_second_passed(time_left: float) -> void:
	time_label.text = str(floor(time_left))
	if time_left < 11:
		if time_left > 0.0:
			SoundManager.play_sound_effect(warning_sound)
		time_label.scale = Vector2.ONE * (1.3 + (0.2 * (10 - time_left)))
		create_tween().set_ease(Tween.EASE_OUT).tween_property(time_label, "scale", Vector2.ONE, 0.25)
