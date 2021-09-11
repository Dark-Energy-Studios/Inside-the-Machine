extends KinematicBody2D

signal dead()
export var health: float = 100.0


func die():
	$CollisionShape2D.queue_free()
	$AnimationPlayer.play("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		emit_signal("dead")
