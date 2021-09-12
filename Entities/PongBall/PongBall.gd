extends KinematicBody2D
class_name PongBall

export var speed: float = 600
export var warnlight: bool = true
export var move: bool = false
var velocity = Vector2.ZERO

func _ready():
	$Light2D.enabled = warnlight
	
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2]

func _physics_process(delta):
	$Light2D.enabled = warnlight
	
	if move:
		var collision_object = move_and_collide(velocity * speed * delta)
		if collision_object:
			velocity = velocity.bounce(collision_object.normal)
