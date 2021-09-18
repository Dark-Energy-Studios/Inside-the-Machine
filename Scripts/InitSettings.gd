extends Settings

func _ready():
	auto_load = true
	auto_save = true

	if gets("fullscreen") == null:
		sets("fullscreen", false)
	
	if gets("master_volume") == null:
		sets("master_volume", -10.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), gets("master_volume"))

	if gets("music_volume") == null:
		sets("music_volume", 0.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), gets("music_volume"))
	
	if gets("fx_volume") == null:
		sets("fx_volume", 0.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), gets("fx_volume"))

	if gets("voice_volume") == null:
		sets("voice_volume", 0.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), gets("voice_volume"))
