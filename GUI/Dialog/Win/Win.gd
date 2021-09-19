extends Control

signal on_next()

var level = 0

func _ready():
	hide()
	$Firework.one_shot = true

func _on_NextButton_pressed():
	emit_signal("on_next")
	
	if try_load_tutorial():
		return
	
	var scene = "res://Level/Level{id}/Level{id}.tscn".format({"id" : level})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
	else:
		get_tree().change_scene("res://Cutscenes/Credits/Credits.tscn")

func try_load_tutorial():
	var scene = "res://Tutorial/Tutorial{id}/Tutorial{id}.tscn".format({"id" : level})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
		return true
	
	return false


func show_dialog(next_level: int):
	show()
	$Firework.emitting = true
	$Firework.one_shot = true
	level = next_level
