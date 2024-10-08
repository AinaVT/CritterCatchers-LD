extends AudioStreamPlayer

var reached_first: bool = false
var reached_second: bool = false


func _ready() -> void:
	EventBus.second_passed.connect(_on_second_passed)


func _on_second_passed(time_left: float) -> void:
	if time_left < 61 and !reached_first:
		reached_first = true
		var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "pitch_scale", 1.15, 2.0)
	elif time_left < 21 and !reached_second:
		reached_second = true
		var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "pitch_scale", 2.0, 20)
