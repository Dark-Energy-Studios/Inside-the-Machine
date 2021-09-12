extends KinematicBody2D
class_name PongPaddle

func move(dir: Vector2, speed: float) -> void:
	move_and_slide(dir * speed)
