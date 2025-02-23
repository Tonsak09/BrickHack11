extends Node2D

@export var speed : float
@export var mag : float 

var timer : float 
var startPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += speed * delta
	
	position = startPos + Vector2.UP * sin(timer) * mag
