extends Control



func _on_Start_pressed():
#	get_tree().change_scene("res://Game/Game.tscn")
	get_tree().change_scene("res://GUI/Intro/GameIntro.tscn")


func _on_Exit_pressed():
	get_tree().quit()
