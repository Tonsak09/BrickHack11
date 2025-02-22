extends Sprite2D

@export var pupilRange : float
@export var lookSpeed : float 

var currentPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized();
	currentPos = lerp(currentPos, dir * pupilRange, delta * lookSpeed)
	
	material.set_shader_parameter("PupilOffset", -currentPos)
