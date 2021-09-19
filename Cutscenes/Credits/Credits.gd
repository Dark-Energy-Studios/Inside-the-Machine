extends Control

func _ready():
	$AnimationPlayer.play("credits")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://GUI/Menu/Menu.tscn")
