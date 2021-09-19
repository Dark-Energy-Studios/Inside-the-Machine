extends Node2D

const LEVEL = 6

func _ready():
	$Game.connect("on_player_won", self, "_on_player_won")
	$Game.connect("on_player_lost", self, "_on_player_lost")

func _on_player_lost():
	$GameOver.show_dialog(LEVEL)
	
func _on_player_won():
	$Win.show_dialog(LEVEL+1)
