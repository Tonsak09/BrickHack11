extends Node2D

@export var visual : Node2D
@export var shiftSpeed : float 

var idle : bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	idle = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	idle = true 


func _on_area_2d_body_entered(body: Node2D) -> void:
	idle = false 
