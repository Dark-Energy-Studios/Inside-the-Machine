extends Node2D

func _ready():
	$AnimationPlayer.play("Tutorial")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Level/Level6/Level6.tscn")
