extends KinematicBody2D

signal dead()
export var health: float = 100.0

var MAX_SPEED = 100
var ACCELERATION = 250
var motion = Vector2()
var flipped: bool = false

func _physics_process(delta):
	move(delta)

func move(delta):
	var axis = get_input_axis()
	flip_or_not(axis)
	animate()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func flip_or_not(axis):
	if axis.x == 0:
		return
	elif axis.x < 0 && !flipped:
		scale.x = -scale.x
		flipped = true
	elif axis.x > 0 && flipped:
		scale.x = -scale.x
		flipped = false

func animate():
	if motion != Vector2.ZERO:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")

func apply_movement(acc):
	motion += acc
	motion = motion.clamped(MAX_SPEED)

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func die():
	$CollisionShape2D.queue_free()
	$AnimationPlayer.play("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		emit_signal("dead")
