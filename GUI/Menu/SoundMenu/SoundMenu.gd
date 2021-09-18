extends Control

signal on_back_pressed(emitter)

var initialized:bool = false

func _ready():
	$GridContainer/MasterSlider.value = settings.gets("master_volume") + $GridContainer/MasterSlider.max_value
	$GridContainer/MusicSlider.value = settings.gets("music_volume") + $GridContainer/MusicSlider.max_value
	$GridContainer/FXSlider.value = settings.gets("fx_volume") + $GridContainer/FXSlider.max_value
	$GridContainer/VoiceSlider.value = settings.gets("voice_volume") + $GridContainer/VoiceSlider.max_value
	
	initialized = true

func _on_Back_pressed():
	emit_signal("on_back_pressed", self)

func _on_MasterSlider_value_changed(value):
	var volume = value - $GridContainer/MasterSlider.max_value
	if value == $GridContainer/MasterSlider.min_value:
		volume = -80
	settings.sets("master_volume", volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)

func _on_MusicSlider_value_changed(value):
	var volume = value - $GridContainer/MusicSlider.max_value
	if value == $GridContainer/MusicSlider.min_value:
		volume = -80
	settings.sets("music_volume", volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume)

func _on_FXSlider_value_changed(value):
	var volume = value - $GridContainer/FXSlider.max_value
	if value == $GridContainer/FXSlider.min_value:
		volume = -80
	settings.sets("fx_volume", volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), volume)

func _on_VoiceSlider_value_changed(value):
	var volume = value - $GridContainer/VoiceSlider.max_value
	if value == $GridContainer/VoiceSlider.min_value:
		volume = -80
	settings.sets("voice_volume", volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), volume)
	
	if (!$Voice.playing) and initialized:
		$Voice.play()

func _on_Reset_pressed():
	$GridContainer/MasterSlider.value = -5.0 + ($GridContainer/MasterSlider.max_value)
	$GridContainer/MusicSlider.value = 0.0 + ($GridContainer/MusicSlider.max_value)
	$GridContainer/FXSlider.value = 0.0 + ($GridContainer/FXSlider.max_value)
	$GridContainer/VoiceSlider.value = 0.0 + ($GridContainer/VoiceSlider.max_value)
