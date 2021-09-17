extends Control

func _on_Start_pressed():
	var tween = get_node("Tween")
	tween.interpolate_property($BackgroundAudio, "volume_db",
			0, -80, 0.1,
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()

func _on_Exit_pressed():
	get_tree().quit()


func _on_Tween_tween_completed(object, key):
	print("tween completed")
	get_tree().change_scene("res://GUI/Intro/GameIntro.tscn")
