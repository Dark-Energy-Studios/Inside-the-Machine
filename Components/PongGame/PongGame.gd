extends Node2D
class_name PongGame

signal ai_score()
signal player_score()

export var player_speed: float = 100
export var ball_speed: float = 50
export var classicly_playing: bool = false
export var ball_warninglight: bool = false
export var ball_moving: bool = false

onready var ball: PongBall = get_node("PongBall")
onready var player_paddle: PongPaddle = get_node("PlayerPaddle")
onready var rotated: bool = int(rotation_degrees) == -90

func _ready():
	sync_ball_settings()
	
	$PlayerPaddle.speed = player_speed
	$AIPaddle.speed = player_speed


func _process(_delta):
	sync_ball_settings()

func _physics_process(_delta):
	if classicly_playing:
		if Input.is_action_pressed("ui_test_up"):
			move_player_paddle_up()
		elif Input.is_action_pressed("ui_test_down"):
			move_player_paddle_down()

		if Input.is_action_pressed("ui_up"):
			move_ai_paddle_up()
		elif Input.is_action_pressed("ui_down"):
			move_ai_paddle_down()


func sync_ball_settings():
	$PongBall.warnlight = ball_warninglight
	$PongBall.move = ball_moving
	$PongBall.speed = ball_speed

func move_player_paddle_up():
	var dir = check_direction(Vector2(0, -1))
	$PlayerPaddle.move(dir)

func move_player_paddle_down():
	var dir = check_direction(Vector2(0, 1))
	$PlayerPaddle.move(dir)

func move_ai_paddle_up():
	var dir = check_direction(Vector2(0, -1))
	$AIPaddle.move(dir)

func move_ai_paddle_down():
	var dir = check_direction(Vector2(0, 1))
	$AIPaddle.move(dir)

func check_direction(dir: Vector2) -> Vector2:
	if rotated:
		var tmp = dir.y
		dir.y = dir.x
		dir.x = tmp

	return dir

func _on_AIGate_body_entered(body):
	if body is PongBall:
		emit_signal("player_score")


func _on_PlayerGate_body_entered(body):
	if body is PongBall:
		emit_signal("ai_score")

func reset_ball():
	$PongBall.position = $Field.position

func move_ball():
	$PongBall.move = true

func stop_ball():
	$PongBall.move = false
