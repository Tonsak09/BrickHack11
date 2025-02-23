extends Camera2D

@export var player : Node2D
@export var speed : float 
@export var followStyle : FollowType

enum FollowType
{
	NONE,
	HORZ,
	VERT,
	FULL
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match followStyle:
		FollowType.NONE:
			pass 
		FollowType.HORZ:
			pass 
		FollowType.VERT:
			pass 
		FollowType.FULL:
			global_position = lerp(global_position, player.global_position, speed * delta) 
