extends Lanius


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_ending.call_deferred()


func start_ending() -> void:
	global_position = get_viewport_rect().get_center()
	await timer(2.0)
	await say("Hmm...", 0.2)
	await cursor_prompt()
	await say("Let's see how you did...")
	await cursor_prompt()
	await say("...", 0.5)
	await cursor_prompt()
	await branch()
	await say("With that, there's nothing really else to say.")
	await cursor_prompt()
	await say("Other than, of course, congratulations!")
	await cursor_prompt()
	await say("Welcome aboard...")
	await cursor_prompt()
	animation_player.play("appear")
	sprite.play("IdleHappy")
	await animation_player.animation_finished
	sprite.play("TalkHappy")
	await say("... the Critter Catchers: Pest Extermination Group!")
	sprite.play("IdleHappy")
	await cursor_prompt()
	Transitioner.transition_scene(preload("res://scenes/credits/credits.tscn"))


func branch() -> void:
	match [GameStats.killed_critters, GameStats.caught_critters, GameStats.escaped_critters]:
		[var k, var c, var e] when k == 0:
			await pacifist_branch()
		[var k, var c, var e] when c == 0 and k >= 30:
			await carnage_branch()
		[var k, var c, var e] when k <= 15:
			await coward_branch()
		[var k, var c, var e] when c < e:
			await inneficient_branch()
		_:
			await default_branch()


func pacifist_branch() -> void:
	await say("You did not touch a single soul...")
	await cursor_prompt()
	await say("I understand this kind of job must be very difficult for the inexperienced...")
	await cursor_prompt()
	await say("But it's alright. There'll be a lot of time for learning and improvement.")
	await cursor_prompt()


func carnage_branch() -> void:
	await say("You didn't catch anything, but...")
	await cursor_prompt()
	await say("... you still decided to show no mercy.")
	await cursor_prompt()
	await say("... kind of cruel, not going to lie...")
	await cursor_prompt()
	await say("... but I guess it gets the job done at the end of the day in a way or another.")
	await cursor_prompt()


func coward_branch() -> void:
	await say("Not many put down, huh...")
	await cursor_prompt()
	await say("I guess it's only natural for a rookie to be very anxious about all of this.")
	await cursor_prompt()
	await say("But it's alright. There'll be a lot of time for learning and improvement.")
	await cursor_prompt()
	await say("For a rookie, it doesn't really matter how many they get in their first try.")
	await cursor_prompt()


func inneficient_branch() -> void:
	await say("You allowed more to escape than you caught...")
	await cursor_prompt()
	await say("I guess it is your first gig after all.")
	await cursor_prompt()
	await say("But it's alright. There'll be a lot of time for learning and improvement.")
	await cursor_prompt()
	await say("For a rookie, it doesn't really matter how many they get in their first try.")
	await cursor_prompt()
	pass


func default_branch() -> void:
	await say("Not bad... not bad...")
	await cursor_prompt()
	await say("Average numbers, I see.")
	await cursor_prompt()
	await say("At the end of the day, your results do not really matter...")
	await cursor_prompt()
	await say("The attitude is what is important in this...")
	await cursor_prompt()
