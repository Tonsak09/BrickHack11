extends Sprite2D

@export var pupilRange : float
@export var lookSpeed : float 

@export var jumpTimer : Timer 
@export var commonScale : Vector2 
@export var squashScale : Vector2
@export var squishScale : Vector2
@export var squishBackSpeed : float 

@export var breatheMag : float 
@export var breatheSpeed : float 

var currentPos : Vector2
var targetScale : Vector2

var timer : float 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetScale = commonScale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized();
	currentPos = lerp(currentPos, dir * pupilRange, delta * lookSpeed)
	
	material.set_shader_parameter("PupilOffset", -currentPos)
	
	timer += breatheSpeed * delta 
	targetScale = commonScale + Vector2(cos(timer + PI) * breatheMag, sin(timer) * breatheMag)
	
	
	
	#position.y =  get_rect().size.y
	if !jumpTimer.is_stopped():
		
		print_debug(jumpTimer.wait_time / jumpTimer.time_left)
		
		scale = lerp(targetScale, squashScale, clampf(jumpTimer.wait_time / jumpTimer.time_left, 0, 1))
	else: 
		scale = lerp(scale, targetScale, squishBackSpeed * delta)



func Squash():
	scale = squishScale
