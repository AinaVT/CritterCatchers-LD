extends Node

var _audio_player_dict: Dictionary = {}


func play_sound_effect(effect: SoundEffect) -> void:
	var player := _player_for_effect(effect)
	if !player: return
	player.play()


func stop_sound_effect(effect: SoundEffect) -> void:
	var player := _player_for_effect(effect)
	if !player: return
	player.stop()


func stop_all_sounds() -> void:
	for weak_ref: WeakRef in _audio_player_dict.values():
		var player := weak_ref.get_ref() as AudioStreamPlayer
		if !player: continue
		player.stop()


func _player_for_effect(effect: SoundEffect) -> AudioStreamPlayer:
	if !_audio_player_dict.has(effect):
		var player := AudioStreamPlayer.new()
		player.stream = effect.stream
		player.max_polyphony = effect.polyphony
		player.bus = "SFX"
		_audio_player_dict[effect] = weakref(player)
		add_child(player)
	
	return _audio_player_dict.get(effect).get_ref()
