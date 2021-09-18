extends Node2D

signal on_player_won()
signal on_player_lost()

var fake_game: PongGame
enum ENERGY_MODEL {OFF, ON, AUTO_RECHARGE}

export var playing: bool = true
export var player_existing: bool = true
export var main_scene: bool = true

export var ball_speed: int = 100
export var player_speed: int = 100
export (ENERGY_MODEL) var energy_model = ENERGY_MODEL.ON

func _ready():
	
	_configure_pong_game()
	_configure_energy_model()
	
	var pos = $Monitor/Position2D.position
	
	var fake_scene = load("res://Components/PongGame/PongGame.tscn")
	fake_game = fake_scene.instance()
	$Monitor.add_child(fake_game)
	fake_game.paddle_shadows = false
	fake_game.ball_moving = false
	fake_game.use_ai = false
	fake_game.classicly_playing = false
	fake_game.position = pos
	fake_game.ball_warninglight = false
	fake_game.scale = Vector2(0.035, 0.03)
	
	$Game_Music.play()
	var tween = get_node("AudioFadeInTween")
	tween.interpolate_property($Game_Music, "volume_db",
			-80, 0, 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	$CountdownClock.start()
	
func _configure_pong_game():
	# passthrough exports
	$PongGame.ball_speed = ball_speed
	$PongGame.player_speed = player_speed
	
func _configure_energy_model():
	match energy_model:
		ENERGY_MODEL.OFF:
			$EnergyScreen.hide()
			$EnergyScreen2.hide()
			$LeftLever.energy_cost = 0
			$RightLever.energy_cost = 0
		ENERGY_MODEL.AUTO_RECHARGE:
			$RechargeTimer.start(1)
	
func _process(_delta):
	fake_game.ball.visible = $PongGame.ball.visible
	fake_game.ball.position = $PongGame.ball.position
	fake_game.player_paddle.position = $PongGame.player_paddle.position
	fake_game.ai_paddle.position = $PongGame.ai_paddle.position

	$PongGame.ball_moving = playing
	$Player.visible = player_existing
	$Player/Camera2D.current = player_existing
	
	var remaining_energy = $Player.getRemainingEnergy()
	$EnergyScreen.update_energy(remaining_energy)
	$EnergyScreen2.update_energy(remaining_energy)
	$Lighting.current_energy = remaining_energy

func _on_PongGame_ai_score():
	$Player.looseLife()
	$LifeScreen.lifes = $Player.getRemainaingLifes()
	$LifeScreen2.lifes = $Player.getRemainaingLifes()
	
	if $Player.getRemainaingLifes() == 0:
		emit_signal("on_player_lost")
	
	$PongGame.reset_ball()

func _on_PongGame_player_score():
	$PongGame.reset_ball()

func _on_LeftLever_on_lever_pressed():
	#if $Player.discharge_energy(100):
	$PongGame.move_player_paddle_up()

func _on_RightLever_on_lever_pressed():
	#if $Player.discharge_energy(100):
	$PongGame.move_player_paddle_down()

func _on_RechargeTimer_timeout():
	$Player.recharge_energy(5)
