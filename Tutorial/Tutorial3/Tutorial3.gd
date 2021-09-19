extends Node2D

func _ready():
	$AnimationPlayer.play("EnergyIntro")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Level/Level3/Level3.tscn")
