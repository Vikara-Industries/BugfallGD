extends Control

var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("Sound")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_music_slider_value_changed(value):
	if value == -30:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)
		AudioServer.set_bus_volume_db(music_bus,value)

func _on_sound_slider_value_changed(value):
	if value == -30:
		AudioServer.set_bus_mute(sound_bus,true)
	else:
		AudioServer.set_bus_mute(sound_bus,false)
		AudioServer.set_bus_volume_db(sound_bus,value)

signal play_button_pressed
func _on_play_button_pressed():
	emit_signal("play_button_pressed")

signal restart_button_pressed
func _on_restart_button_pressed():
	emit_signal("restart_button_pressed")
