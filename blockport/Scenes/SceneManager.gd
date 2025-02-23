extends Node2D

@export var player : Node2D
var spawnPoint : Vector2

#@export var levels : Array[]


func _ready() -> void:
	spawnPoint = player.global_position
	
func AdjustSpawnPoint(pos : Vector2):
	spawnPoint = pos 

func RespawnPlayer():
	player.global_position = spawnPoint 
