extends Node
class_name game_director

enum game_state{PAUSED, PLAY, RESTART}
var current_game_state = game_state.PAUSED

var current_level 

@onready var pause_menu = get_parent().get_node("Scafold/PauseLayer/pause")
@onready var level1 = preload("res://Scenes/Level1.tscn")

func _ready():
	pause_menu.play_button_pressed.connect(_on_pause_play_button_pressed)
	pause_menu.restart_button_pressed.connect(_on_pause_restart_button_pressed)
	current_level = level1.instantiate()
	add_child(current_level)
	change_state(game_state.PAUSED)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		if current_game_state == game_state.PAUSED:
			change_state(game_state.PLAY)
		elif current_game_state == game_state.PLAY:
			change_state(game_state.PAUSED)


func change_state(state):
	match state:
		0:
			pause_game()
		1:
			play_game()
		2:
			restart()

func pause_game():
	current_game_state = game_state.PAUSED
	get_tree().paused = true
	pause_menu.show()
	
func play_game():
	current_game_state = game_state.PLAY
	get_tree().paused = false
	pause_menu.hide()

func restart():
	get_child(current_level.get_index()).queue_free()
	current_level = level1.instantiate()
	add_child(current_level)
	play_game()

func _on_pause_play_button_pressed():
	change_state(game_state.PLAY)
	
func _on_pause_restart_button_pressed():
	change_state(game_state.RESTART)
