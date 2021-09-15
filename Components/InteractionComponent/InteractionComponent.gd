extends Area2D


export var interaction_parent: NodePath

signal on_interactable_changed(new_interactable)

var interaction_target: Node

func _process(_delta):
	if interaction_target != null and Input.is_action_just_pressed("interact"):
		if interaction_target.has_method("interaction_interact"):
			interaction_target.interaction_interact(self)

func _on_InteractionComponent_body_entered(body):
	print(body)
	var can_interact := false
	
	if body.has_method("interaction_can_interact"):
		can_interact = body.interaction_can_interact(get_node(interaction_parent))
		
	if not can_interact:
		return
		
	interaction_target = body
	emit_signal("on_interactable_changed", interaction_target)


func _on_InteractionComponent_body_exited(body):
	if body == interaction_target:
		interaction_target = null
		if body.has_method("interaction_not_interacted"):
			# Called when entity stepped outside of object range again
			body.interaction_not_interacted(interaction_parent) 
		emit_signal("on_interactable_changed", null)
