extends Control

signal approved()

func _process(delta):
	if visible == true and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("flicker")

func _on_Yes_pressed():
	emit_signal("approved")
