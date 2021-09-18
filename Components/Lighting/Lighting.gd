extends Node2D

export var music_path: NodePath
export var react_to_light: bool = true
onready var music: AudioStreamPlayer = get_node(music_path)

var current_energy: float setget apply_energy 

func _ready():
	$Timer.start(0.46875)

func apply_energy(val):
	current_energy = val/100.0
	print(current_energy)

func _on_Timer_timeout():
	for child in get_children():
		if child.has_method("fire_tween"):
			child.fire_tween(current_energy)
