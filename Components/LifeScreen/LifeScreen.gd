extends Node2D

var MAX_LIFES = 3

var lifes = 3 setget update_lifes

func update_lifes(remainingLifes:int):
	lifes = clamp(remainingLifes,0,MAX_LIFES)
	$Monitor/AnimatedSprite.play(str(remainingLifes))
