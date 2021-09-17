extends Node

var running:bool = false
export var recharge_amount = 5

signal on_trainer_use()

# trainer left lever
signal on_trainer_reset()

# trainer status has changed
signal on_trainer_changed()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func interaction_can_interact(interaction_parent: Node):
	return true

func interaction_interact(interaction):
	if interaction.get_node(interaction.interaction_parent).recharge_energy(recharge_amount):
		running = true
		#$AnimatedSprite.play("default")
		emit_signal("on_trainer_changed")
		emit_signal("on_trainer_pressed")
		
		

