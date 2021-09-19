extends Node2D

onready var anims: Array = $AnimationPlayer.get_animation_list()

export (Array, AudioStream) var voice_lines

var ready_to_change: bool = false

func _ready():
	randomize()
	if len(Global.meeting_voice_lines_order) == 0:
		for i in range(0, len(voice_lines)):
			Global.meeting_voice_lines_order.append(i)
		Global.meeting_voice_lines_order.shuffle()
	
	$Boss.stream = voice_lines[Global.get_next_meeting_voice_line()]
	play_random_anim()
	$Boss.play()

func _on_AnimationPlayer_animation_finished(_anim_name):
	if ready_to_change:
		redirect_to_next_scene()
		return
	play_random_anim()

func play_random_anim():
	var anim: String = anims[randi() % len(anims)]
	anims.erase(anim)
	
	if (randi() % 2 == 1):
		$AnimationPlayer.play(anim)
	else:
		$AnimationPlayer.play_backwards(anim)

func redirect_to_next_scene():
	get_tree().change_scene(
		"res://Level/Level{current_level}/Level{current_level}.tscn".format(
			{
				"current_level": Global.current_level
			}
		)
	)


func _on_Boss_finished():
	ready_to_change = true
