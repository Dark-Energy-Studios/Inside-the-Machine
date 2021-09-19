extends Control

signal on_retry()

var level = 1

func _ready():
	hide()

func _on_RetryButton_pressed():
	emit_signal("on_retry")
	var scene = "res://Level/Level{id}/Level{id}.tscn".format({"id" : level})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
	else:
		print("Scene '{scene}' doesn't exist!".format({"scene": scene}))

func show_dialog(retry_level: int):
	level = retry_level
	show()
