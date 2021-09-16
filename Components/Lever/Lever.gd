extends StaticBody2D

export var energy_cost = 5

var pressed:bool = false

# player interacted with lever
signal on_lever_pressed()

# player left lever
signal on_lever_reset()

# lever status has changed
signal on_lever_changed()

func interaction_can_interact(interaction_parent: Node):
	return true

func interaction_interact(interaction):
	if pressed:
		return
	if interaction.get_node(interaction.interaction_parent).discharge_energy(energy_cost):
		pressed = true
		$AnimatedSprite.play("default")
		emit_signal("on_lever_changed")
		emit_signal("on_lever_pressed")

func interaction_not_interacted(interaction):
	if pressed:
		$AnimatedSprite.play("default", true)
		pressed = false
	emit_signal("on_lever_changed")
	emit_signal("on_lever_reset")
