extends StaticBody2D

var lost_walkman_vibes:bool = false

func interaction_can_interact(interaction_parent: Node):
	return true

func interaction_interact(interaction):
	if !lost_walkman_vibes:
		get_parent().get_node("BackgroundAudio").stop()
		$Default_Music.play()
	else:
		$Default_Music.stop()
		get_parent().get_node("BackgroundAudio").play()
		
	lost_walkman_vibes = !lost_walkman_vibes
