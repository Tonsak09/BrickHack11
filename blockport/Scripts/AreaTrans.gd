extends Area2D

@export var cam : Camera2D
@export var pos : Node2D
@export var tp : Node2D

func Transition(body : Node2D):
	cam.global_position = pos.global_position 
	body.global_position = tp.global_position
