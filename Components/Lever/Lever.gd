extends StaticBody2D

export var energy_cost = 5
export var flip_instruction_key: bool = false

const valid_sound = preload("res://Media/Audio/lever_valid_sound.wav")
const invalid_sound = preload("res://Media/Audio/lever_invalid_sound.wav")

var pressed:bool = false
var current_interaction

# player interacted with lever
signal on_lever_pressed()

# player left lever
signal on_lever_reset()

# lever status has changed
signal on_lever_changed()

func _ready():	
	if flip_instruction_key:
		$EKey.scale.x *= -1

func interaction_can_interact(interaction_parent: Node):
	$EKey.visible = true
	return true

func interaction_interact(interaction):
	if interaction.get_node(interaction.interaction_parent).discharge_energy(energy_cost):
		pressed = true
		$AnimatedSprite.play("default")
	
		$Lever_FX.stream = valid_sound
		$Lever_FX.play()
		emit_signal("on_lever_changed")
		emit_signal("on_lever_pressed")
		$Timer.start(.5)
		current_interaction = interaction
	else:
		$Lever_FX.stream = invalid_sound
		$Lever_FX.play()

func interaction_not_interacted(interaction):
	if pressed:
		$AnimatedSprite.play("default", true)
		pressed = false
	emit_signal("on_lever_changed")
	emit_signal("on_lever_reset")
	$EKey.visible = false

func _on_Timer_timeout():
	interaction_not_interacted(current_interaction)
