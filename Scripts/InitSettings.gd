extends Settings

func _ready():
	auto_load = true
	auto_save = true

	if gets("fullscreen") == null:
		sets("fullscreen", false)

	if gets("master-volume") == null:
		sets("master-volume", 100.0)
