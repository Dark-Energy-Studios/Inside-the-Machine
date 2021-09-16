extends Node2D

var fake_game: PongGame

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

func _process(_delta):
	fake_game.ball.visible = $PongGame.ball.visible
	fake_game.ball.position = $PongGame.ball.position
	fake_game.player_paddle.position = $PongGame.player_paddle.position
	fake_game.ai_paddle.position = $PongGame.ai_paddle.position
	$CanvasLayer/Energy.text = "Energy: %d" % $Player.energy
	$CanvasLayer/Life.text = "Life: %d" % $Player.lifes

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
