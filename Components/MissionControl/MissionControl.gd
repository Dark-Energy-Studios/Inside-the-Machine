extends Node2D

export var block_pause_room:bool = false

func _ready():
	if !block_pause_room:
		remove_child($VLCPlayer)
