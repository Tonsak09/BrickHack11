extends CharacterBody2D


@export_category("Movement")
@export var accel : float
@export var maxSpeed : float 
@export var resistance : float 
@export var gravity : float 
@export var jumpSpeed : float 
@export var wallJumpSpeed : Vector2 

@export var wallSlideTimer : Timer

@export_category("Cling")
@export var wallCheck : Area2D
@export var wallLeft : Area2D
@export var wallRight : Area2D
@export var floorCheck : Area2D
@export var slideSpeed : float 

@export_category("Passthrough")
@export var passthroughCheker : ShapeCast2D

@export_category("Particles")
@export var rightTrail : CPUParticles2D
@export var leftTrail : CPUParticles2D

var vel : Vector2 
var grounded : bool 


var yVelHold = 0.0


enum PlayerMoveStates { FREE = 0, CLUNG = 1, PASSING = 2 }
var moveState : PlayerMoveStates


func _init() -> void:
	grounded = false 
	#moveState = PlayerMoveStates.FREE


func _process(delta: float) -> void:
	match moveState:
		PlayerMoveStates.FREE:
			FreeMovement(delta)
		PlayerMoveStates.CLUNG:
			ClungMovement(delta)
		PlayerMoveStates.PASSING:
			pass  
	
	
	if velocity.x <= -10:
		rightTrail.emitting = true 
		leftTrail.emitting = false  
	elif velocity.x >= 10:
		print_debug(velocity.x)
		rightTrail.emitting = false  
		leftTrail.emitting = true 
	else :
		rightTrail.emitting = false  
		leftTrail.emitting = false 

func _physics_process(delta: float) -> void:
	pass
	
	



func FreeMovement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2(0, gravity) * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpSpeed

	# X axis input 
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), 0.0).normalized();
	
	
	# Try to jump 
	if (grounded || abs(yVelHold) <= 0.001) && Input.is_action_pressed("Jump") && floorCheck.has_overlapping_bodies():
		velocity.y = jumpSpeed
		grounded = false 
	
	# Movement input 
	if dir:
		velocity += dir * delta * accel
	
	
	if Input.is_action_pressed("Cling") && (wallLeft.has_overlapping_bodies() || wallRight.has_overlapping_bodies()) && wallSlideTimer.is_stopped():
		velocity = Vector2(0,0)
		moveState = PlayerMoveStates.CLUNG
	
	if (velocity.y > 0 && wallSlideTimer.is_stopped()):
		# Check if sliding 
		if wallLeft.has_overlapping_bodies():
			velocity.y = slideSpeed
			
		elif wallRight.has_overlapping_bodies():
			velocity.y = slideSpeed
	
	velocity -= Vector2(velocity.x, 0) * resistance;
	yVelHold = (yVelHold + velocity.y) / 2.0 # If player is still long enough 
	
	move_and_slide() 

func ClungMovement(delta):
	if( Input.is_action_just_released("Cling")):
		moveState = PlayerMoveStates.FREE
		return
	
	if Input.is_action_just_pressed("Jump") && wallSlideTimer.is_stopped():
		var dir = Vector2(
			Input.get_axis("ui_left", "ui_right"), 
			-1.0).normalized(); 
		
		velocity = Vector2(dir.x * wallJumpSpeed.x, dir.y * wallJumpSpeed.y)
		wallSlideTimer.start()
		moveState = PlayerMoveStates.FREE
	
	if Input.is_action_just_pressed("Passthrough"):
		var dir = Vector2(Input.get_axis("ui_left", "ui_right"), 0);
		if dir.x > 0:
			if wallRight.has_overlapping_bodies():
				print_debug(wallRight.get_overlapping_bodies()[0].get_child(0).shape.get_rect().size)
				global_position += Vector2(abs(wallRight.get_overlapping_bodies()[0].get_child(0).global_position.x - global_position.x) * 2.0, 0)
		else:
			if wallLeft.has_overlapping_bodies():
				print_debug(wallLeft.get_overlapping_bodies()[0])
				global_position -= Vector2(abs(wallLeft.get_overlapping_bodies()[0].get_child(0).global_position.x - global_position.x) * 2.0, 0)

func DetectCollision(body : Node2D):
	grounded = true

func DetectCollisionLeave(body : Node2D):
	grounded = false 
