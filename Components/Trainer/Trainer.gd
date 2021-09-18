extends Node

export var recharge_amount = 2

signal on_trainer_use()

# trainer left lever
signal on_trainer_reset()

# trainer status has changed
signal on_trainer_changed()

func interaction_can_interact(interaction_parent: Node):
	return true

func interaction_interact(interaction):
	interaction.get_node(interaction.interaction_parent).recharge_energy(recharge_amount)

	#$AnimatedSprite.play("default")
	emit_signal("on_trainer_changed")
	emit_signal("on_trainer_pressed")
		
	# Stop timer to prevent stop animation
	$StopTimer.stop()
		
	# Play fitness animation which just resets the audio properties to the
	# default
	$AnimationPlayer.play("fitness")

	# Start walking sound if loop isn't already running
	if ! $Walking_FX.playing:
		$Walking_FX.play()

	# Start timer to stop walking sound if the player lefts the trainer
	$StopTimer.start()

func _on_StopTrainer_timeout():
	$AnimationPlayer.play("stop")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "stop":
		$Walking_FX.stop()
