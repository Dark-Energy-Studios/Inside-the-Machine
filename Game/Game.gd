extends Node2D

var fake_game: PongGame
export var playing: bool = true
export var player_existing: bool = true

func _ready():
	var pos = $Monitor/Position2D.position
	
	var fake_scene = load("res://Components/PongGame/PongGame.tscn")
	fake_game = fake_scene.instance()
	$Monitor.add_child(fake_game)
	fake_game.ball_moving = false
	fake_game.use_ai = false
	fake_game.classicly_playing = false
	fake_game.position = pos
	fake_game.ball_warninglight = false
	fake_game.scale = Vector2(0.035, 0.03)
	
	var tween = get_node("AudioFadeInTween")
	tween.interpolate_property($BackgroundAudio, "volume_db",
			-80, 0, 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _process(_delta):
	fake_game.ball.visible = $PongGame.ball.visible
	fake_game.ball.position = $PongGame.ball.position
	fake_game.player_paddle.position = $PongGame.player_paddle.position
	fake_game.ai_paddle.position = $PongGame.ai_paddle.position
	$CanvasLayer/Energy.text = "Energy: %d" % $Player.energy

	$PongGame.ball_moving = playing
	$Player.visible = player_existing
	$Player/Camera2D.current = player_existing

func _on_PongGame_ai_score():
	$LifeScreen.lifes = $Player.looseLife()
	$PongGame.reset_ball()

func _on_PongGame_player_score():
	$PongGame.reset_ball()

func _on_LeftLever_on_lever_pressed():
	#if $Player.discharge_energy(100):
	$PongGame.move_player_paddle_up()

func _on_RightLever_on_lever_pressed():
	#if $Player.discharge_energy(100):
	$PongGame.move_player_paddle_down()
