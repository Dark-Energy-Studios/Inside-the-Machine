extends PongGame

export var use_ai: bool = false
onready var ai_paddle: PongPaddle = get_node("AIPaddle")

func _physics_process(_delta):
	if use_ai:
		var b_pos = ball.position
		var ai_pos = ai_paddle.position
		
		if b_pos.y > ai_pos.y:
			move_ai_paddle_down()
		elif b_pos.y < ai_pos.y:
			move_ai_paddle_up()
