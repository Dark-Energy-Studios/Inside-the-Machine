extends Node2D

onready var anims = $AnimationPlayer.get_animation_list()

export (Array, AudioStream) var voice_lines

var ready_to_change: bool = false

func _ready():
	randomize()
	play_random_anim()
	$Boss.stream = voice_lines[randi() % len(voice_lines)]
	$Boss.play()

func _on_AnimationPlayer_animation_finished(_anim_name):
	if ready_to_change:
		redirect_to_next_scene()
		return
	play_random_anim()

func play_random_anim():
	if (randi() % 2 == 1):
		$AnimationPlayer.play(anims[randi() % len(anims)])
	else:
		$AnimationPlayer.play_backwards(anims[randi() % len(anims)])

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
