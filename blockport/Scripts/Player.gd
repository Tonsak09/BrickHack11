extends CharacterBody2D


@export_category("Movement")
@export var accel : float
@export var maxSpeed : float 
@export var resistance : float 
@export var gravity : float 
@export var jumpSpeed : float 

var vel : Vector2 
var grounded : bool 


var yVelHold = 0.0


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _init() -> void:
	grounded = false 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2(0, gravity) * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), 0.0).normalized();
	if (grounded || abs(yVelHold) <= 0.001) && Input.is_action_pressed("Jump"):
		velocity.y = jumpSpeed
		grounded = false 
		
	
	print_debug(Input.is_action_pressed("Cling"))
	
	if direction:
		velocity += dir * delta * accel
	
	
	velocity -= Vector2(velocity.x, 0) * resistance;
	yVelHold = (yVelHold + velocity.y) / 2.0 # If player is still long enough 
	
	move_and_slide()

func DetectCollision(body : Node2D):
	grounded = true

func DetectCollisionLeave(body : Node2D):
	grounded = false 
