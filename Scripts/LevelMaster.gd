extends Node
class_name LevelMaster

var player = preload("res://Tsns/Player.tscn")
var lives = 3
var score :int = 0
@onready var level :LevelMatrix = $"../LevelMatrix"
@onready var playerSpawnPoint = $"../playerSpawn"

func _ready():
	spawnPlayer()

func pushNewRow(rowOnStateList = null):
	if rowOnStateList == null:
		level.pushNewRowFromBottom()
	else:
		level.pushNewRowFromBottom(rowOnStateList)

func spawnPlayer():
	var newPlayer = player.instantiate()
	newPlayer.connect("playerDead",onPlayerDead)
	playerSpawnPoint.add_child(newPlayer)
	
func increaseScore():
	score += 1
	
func onPlayerDead():
	if lives > 0:
		lives -= 1
		call_deferred("spawnPlayer")

func _input(event):
	if event is InputEventKey and event.keycode == KEY_R and event.is_released():
		pushNewRow()
	if event is InputEventKey and event.keycode == KEY_T and event.is_released():
		pushNewRow([true,true,true,true,true])
# Called when the node enters the scene tree for the first time.



