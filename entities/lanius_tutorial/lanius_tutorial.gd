class_name LaniusTutorial
extends Lanius

signal started_tutorial
signal triggered_bunny
signal enabled_shooting
signal enabled_wrapping

signal _bunny_slept
signal _bunny_died
signal _bunny_wrapped


func _ready() -> void:
	start_tutorial.call_deferred()


func start_tutorial() -> void:
	await timer(1.0)
	global_position = get_viewport_rect().get_center()
	animation_player.play("appear")
	await animation_player.animation_finished
	started_tutorial.emit()
	sprite.play("Talk")
	await say("Hmm...", 0.2)
	sprite.play("Idle")
	await cursor_prompt()
	if Config.has_played:
		sprite.play("Talk")
		await say("Seems like you've been here before. You know the drill.")
		sprite.play("Idle")
		await cursor_prompt()
		Transitioner.transition_scene(preload("res://scenes/game/game_scene.tscn"))
		return
		
	sprite.play("Talk")
	await say("I don't think I've seen your face around here before.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("TalkHappy")
	await say("So you're here to catch some critter? Awesome!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	sprite.play("Talk")
	await say("My name is Lanius and I will be teaching you all you need to know about this wonderful job.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("TalkHappy")
	await say("But I promise it will be a piece of cake for you!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	sprite.play("Talk")
	await say("But I have to warn y-")
	triggered_bunny.emit()
	clear_dialogue()
	sprite.play("Surprised")
	await timer(0.5)
	animation_player.play("disappear")
	await animation_player.animation_finished
	global_position.x -= 96
	global_position.y = get_viewport_rect().size.y - 48
	animation_player.play("appear")
	await animation_player.animation_finished
	await _bunny_slept
	sprite.play("Talk")
	await say("Well, how convenient.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("TalkHappy")
	await say("And it's asleep too! Makes my life slightly easier!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	sprite.play("Talk")
	await say("Now, whenever you're ready to start catching, use your cursor to left click on them.")
	sprite.play("Idle")
	enabled_shooting.emit()
	await _bunny_died
	clear_dialogue()
	await timer(1.5)
	sprite.play("TalkHappy")
	await say("Good job!!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	sprite.play("Talk")
	await say("Now, put them in one of your body bags by holding right click on them.")
	sprite.play("Idle")
	enabled_wrapping.emit()
	await _bunny_wrapped
	await timer(1.0)
	sprite.play("TalkHappy")
	await say("Excellent!!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	sprite.play("Talk")
	await say("That's pretty much all you need to know.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("Talk")
	await say("Try to catch as many as you can.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("Talk")
	await say("Or at the very least, do not let them escape.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("Talk")
	await say("You have three minutes.")
	sprite.play("Idle")
	await cursor_prompt()
	sprite.play("TalkHappy")
	await say("Good luck!!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	Transitioner.transition_scene(preload("res://scenes/game/game_scene.tscn"))


func on_bunny_slept() -> void:
	_bunny_slept.emit()


func on_bunny_died() -> void:
	_bunny_died.emit()


func on_bunny_wrapped() -> void:
	_bunny_wrapped.emit()
