extends Node2D

var index: int = 1

func _ready():
	$AnimationPlayer.play("Intro1")

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		index += 1
		if index > len($AnimationPlayer.get_animation_list()):
			get_tree().change_scene("res://Game/Game.tscn")
		else: 
			$AnimationPlayer.play("Intro"+str(index))
