extends StaticBody2D

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
