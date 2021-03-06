extends Node2D

export (AudioStream) var voice_line: AudioStream

func _ready():
	$Boss.stream = voice_line
	$Boss.play()

func goodbye():
	$AnimationPlayer.play("WalkingOut")

func _on_Boss_finished():
	goodbye()


func _on_AnimationPlayer_animation_finished(anim_name):
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")
	
	get_tree().quit()
