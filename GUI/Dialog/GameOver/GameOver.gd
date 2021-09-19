extends Control

signal on_retry()
signal on_next()

var _retry_level = 1
var _next_level = 1

func _ready():
	hide()
	$Warnings.play(str(Global.employee_warnings))

func _on_RetryButton_pressed():
	emit_signal("on_retry")
	var scene = "res://Level/Level{id}/Level{id}.tscn".format({"id" : _retry_level})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
	else:
		print("Scene '{scene}' doesn't exist!".format({"scene": scene}))

func show_dialog(retry_level: int, next_level: int):
	_retry_level = retry_level
	_next_level = next_level
	show()

func _on_WarningButton_pressed():
	Global.employee_warnings = min(3, Global.employee_warnings+1)
	$Warnings.play(str(Global.employee_warnings))
	
	if Global.employee_warnings >= 3:
		return
	
	# TODO: Johannes can place personal talk or fire meeting in here
	
	var scene = "res://Level/Level{id}/Level{id}.tscn".format({"id" : _next_level})
	if ResourceLoader.exists(scene):
		get_tree().change_scene(scene)
	else:
		print("Scene '{scene}' doesn't exist!".format({"scene": scene}))
