extends Node2D
class_name PongGame

signal ai_score()
signal player_score()

export var player_speed: float = 100
onready var ball: PongBall = get_node("PongBall")

func move_player_paddle_up():
	$PlayerPaddle.move(Vector2(0, -1), player_speed)

func move_player_paddle_down():
	$PlayerPaddle.move(Vector2(0, 1), player_speed)

func _on_AIGate_body_entered(body):
	if body is PongBall:
		emit_signal("player_score")


func _on_PlayerGate_body_entered(body):
	if body is PongBall:
		emit_signal("ai_score")


## CODE DOWN HERE IS TEMPORARY
## REMOVE BEFORE COMMITING

func _process(_delta):
	if Input.is_action_pressed("ui_test_up"):
		move_player_paddle_up()
	elif Input.is_action_pressed("ui_test_down"):
		move_player_paddle_down()

	if Input.is_action_pressed("ui_up"):
		move_ai_paddle_up()
	elif Input.is_action_pressed("ui_down"):
		move_ai_paddle_down()

func move_ai_paddle_up():
	$AIPaddle.move(Vector2(0, -1), player_speed)

func move_ai_paddle_down():
	$AIPaddle.move(Vector2(0, 1), player_speed)
