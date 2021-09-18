extends Node2D

var index: int = 0

func _ready():
	$AnimationPlayer.play("Intro0")

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		index += 1
		if index > len($AnimationPlayer.get_animation_list()) - 1:
			get_tree().change_scene("res://Level/Level1/Level1.tscn")
		else: 
			$AnimationPlayer.play("Intro"+str(index))
