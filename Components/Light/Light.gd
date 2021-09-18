extends Light2D

func fire_tween(energy: float):
	$Tween.interpolate_property(self, "energy",
				0.75*energy, 1*energy, .3,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
