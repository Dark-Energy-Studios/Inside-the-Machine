extends Node2D

signal on_countdown_expired()
signal on_countdown_tick(remaining)
signal on_countdown_stopped()

export var duration:int = 60
var time_remaining:int

func _on_Timer_timeout():
	time_remaining -= 1
	update_label(time_remaining)
	if time_remaining == 0:
		emit_signal("on_countdown_expired")
		stop()
	else:
		emit_signal("on_countdown_tick", time_remaining)	

	
func update_label(time):
	var minute = time / 60
	var seconds = time % 60
	$Sprite/Label.text  = "%d:%02d" % [minute, seconds]
	
func start():
	time_remaining = duration
	$Timer.start(1.0)
	
func stop():
	$Timer.stop()
	emit_signal("on_countdown_stopped", time_remaining)
