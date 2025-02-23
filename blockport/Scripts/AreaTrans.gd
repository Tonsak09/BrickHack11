extends Area2D

@export var cam : Camera2D
@export var pos : Node2D
@export var tp : Node2D

var sm

func _ready() -> void:
	sm = get_tree().get_root().get_child(0).get_node("SceneManager")

func Transition(body : Node2D):
	cam.global_position = pos.global_position 
	body.global_position = tp.global_position
	
	sm.AdjustSpawnPoint(tp.global_position)
