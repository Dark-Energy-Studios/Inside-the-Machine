extends Node2D

var cameras: Array = Array()
var old_index: int = 0
onready var ui: Control

func _ready():
	ui = get_node("UI")
	cameras.append(get_node("Camera2D"))
	inject_cameras()
	$PongGame.player_paddle.speed += 50
	switch_cam(2)
	

func inject_cameras():
	$PongGame.player_paddle.add_child(create_new_focus_camera())
	cameras.append($PongGame.player_paddle.get_node("Camera2D"))
	
	$PongGame.ai_paddle.add_child(create_new_focus_camera())
	cameras.append($PongGame.ai_paddle.get_node("Camera2D"))

	$PongGame.ball.add_child(create_new_focus_camera())
	cameras.append($PongGame.ball.get_node("Camera2D"))

func create_new_focus_camera() -> Camera2D:
	var cam = Camera2D.new()
	cam.name = "Camera2D"
	cam.zoom = Vector2(0.5, 0.5)
	cam.scale = Vector2(0.5, 0.5)
	cam.set_anchor_mode(Camera2D.ANCHOR_MODE_DRAG_CENTER)
	
	return cam

func switch_cam(new_index):
	ui = cameras[old_index].get_node("UI")
	cameras[old_index].remove_child(ui)
	cameras[old_index].current = false
	
	if new_index != 0:
		if old_index != 0:
			ui.rect_position -= Vector2(160, 80)
	else:
		ui.rect_position -= Vector2.ZERO
	
	old_index = new_index
	cameras[new_index].add_child(ui)
	cameras[new_index].current = true

func _on_score():
	$PongGame.reset_ball()
