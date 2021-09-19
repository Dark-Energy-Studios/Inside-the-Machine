extends Node2D

const LEVEL = 1

func _on_Game_on_player_lost():
	$GameOver.show_dialog(LEVEL)
	
func _on_Game_on_player_won():
	$Win.show_dialog(LEVEL+1)

func _on_GameOver_on_dialog_finished():
	print("game over")

func _on_Win_on_dialog_finished():
	print("win")
