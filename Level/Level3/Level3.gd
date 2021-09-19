extends Node2D

const LEVEL = 3

func _ready():
	$Game.connect("on_player_won", self, "_on_player_won")
	$Game.connect("on_player_lost", self, "_on_player_lost")

func _on_player_lost():
	$GameOver.show_dialog(LEVEL)
	
func _on_player_won():
	$Win.show_dialog(LEVEL+1)

func _on_Debug_pressed():
	var scene = "res://Level/Level{id}/Level{id}.tscn".format({"id" : LEVEL})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
	else:
		print("Scene '{scene}' doesn't exist!".format({"scene": scene}))
