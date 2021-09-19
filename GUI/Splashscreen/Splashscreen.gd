extends Control

func _ready():
	$AnimationPlayer.play("Neue Animation")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://GUI/Menu/Menu.tscn")
