extends Node2D

signal on_countdown_expired()
signal on_countdown_tick(remaining)

export var duration:int = 60
var time_remaining:int

func _ready():
	var minute = duration / 60
	var seconds = duration % 60
	var time_label = "%d:%02d" % [minute, seconds]
	
	$Sprite/Label.text = time_label
	

func _on_Timer_timeout():
	time_remaining -= 1
	var minute = time_remaining / 60
	var seconds = time_remaining % 60
	var time_label = "%d:%02d" % [minute, seconds]
	$Sprite/Label.text = time_label
	if time_remaining == 0:
		emit_signal("on_countdown_expired")
		$Timer.stop()
	else:
		emit_signal("on_countdown_tick", time_remaining)	

	
func start():
	time_remaining = duration
	$Timer.start(1.0)
	
	

