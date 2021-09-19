extends Node2D

signal on_player_won()
signal on_player_lost()

var fake_game: PongGame

export var playing: bool = true
export var player_existing: bool = true
export var main_scene: bool = true

export var ball_speed: int = 100
export (int, 50, 2000,50) var paddle_speed = 1100

export var block_pause_room:bool = false

enum ENERGY_MODEL {OFF, ON, AUTO_RECHARGE}
export (ENERGY_MODEL) var energy_model = ENERGY_MODEL.ON
export(float, 0.3, 10,0.1) var energy_recharge_rate = 1
export(int, 1, 10, 1) var trainer_recharge_amount = 5
export(int, 1, 10, 1) var lever_energy_cost = 5

export var easter_egg:bool = false

export (int, 2, 300, 10) var countdown_duration = 60

enum MUSIC_TIME_MARKER {START, HI_HATS, SIRENE, ARP_INTRO, BREAK_UP, DROP, BREAK_DOWN, OUTRO}
var time_marker_values = [0.0, 30.0, 65.15, 76.874, 103.12, 106.868, 141.088, 180]
export(MUSIC_TIME_MARKER) var music_time_marker = 0


func _ready():
	_configure_pong_game()
	_configure_energy_model()
	
	if !block_pause_room:
		$MissionControl.unblock_pause_room()
	
	$Trainer.recharge_amount = trainer_recharge_amount
	$LeftLever.energy_cost = lever_energy_cost
	$RightLever.energy_cost = lever_energy_cost
	
	if !easter_egg:
		remove_child($default)
	
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
	
	$Game_Music.play(time_marker_values[music_time_marker])
	var tween = get_node("AudioFadeInTween")
	tween.interpolate_property($Game_Music, "volume_db",
			-80, 0, 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	$CountdownClock.duration = countdown_duration
	$CountdownClock.start()
	
func _configure_pong_game():
	# passthrough exports
	$PongGame.ball_speed = ball_speed
	$PongGame.paddle_speed = paddle_speed
	
func _configure_energy_model():
	match energy_model:
		ENERGY_MODEL.OFF:
			$EnergyScreen.hide()
			$EnergyScreen2.hide()
			$LeftLever.energy_cost = 0
			$RightLever.energy_cost = 0
		ENERGY_MODEL.AUTO_RECHARGE:
			$RechargeTimer.start(energy_recharge_rate)
	
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
	$Player.recharge_energy(1)

func _on_CountdownClock_on_countdown_expired():
	playing = false
	emit_signal("on_player_won")

func _on_Player_dead():
	$CountdownClock.stop()
	playing = false
	emit_signal("on_player_lost")
