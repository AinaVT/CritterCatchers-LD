extends CanvasLayer

const DEFAULT_DURATION := 2.0

@onready var fade_rect := $ColorRect

var is_transitioning := false
var _current_tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_rect.color = Color(0,0,0,1)
	await _fade_in()


func _fade_out(duration: float = DEFAULT_DURATION / 2) -> Signal:
	if _current_tween && _current_tween.is_running():
		_current_tween.stop()
		_current_tween = null
	
	_current_tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	return _current_tween.tween_property(fade_rect, "color", Color(0, 0, 0, 1), duration).finished


func _fade_in(duration: float = DEFAULT_DURATION / 2) -> Signal:
	if _current_tween && _current_tween.is_running():
		_current_tween.stop()
		_current_tween = null
	
	_current_tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	return _current_tween.tween_property(fade_rect, "color", Color(0, 0, 0, 0), duration).finished


func transition(action: Callable, duration: float = DEFAULT_DURATION) -> void:
	if is_transitioning: return
	
	is_transitioning = true
	await _fade_out(duration / 2)
	action.call()
	await _fade_in(duration / 2)
	is_transitioning = false


func transition_scene(scene: PackedScene, duration: float = DEFAULT_DURATION) -> void:
	var action := get_tree().change_scene_to_packed.bind(scene)
	await transition(action, duration)
