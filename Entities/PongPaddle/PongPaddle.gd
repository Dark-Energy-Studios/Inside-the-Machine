extends KinematicBody2D
class_name PongPaddle

export var speed: float

func move(dir: Vector2) -> void:
	move_and_slide(dir * speed)
