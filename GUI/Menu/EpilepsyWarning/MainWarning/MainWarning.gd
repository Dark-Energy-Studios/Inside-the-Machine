extends Control

signal accepted()

func _on_Ok_pressed():
	emit_signal("accepted")
