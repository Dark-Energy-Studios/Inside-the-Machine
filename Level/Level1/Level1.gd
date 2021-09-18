extends Node2D

const LEVEL = 1

signal on_player_lost(level)
signal on_player_won(level)

func _on_Game_on_player_lost():
	emit_signal("on_player_lost",LEVEL)

func _on_Game_on_player_won():
	emit_signal("on_player_lost",LEVEL)
