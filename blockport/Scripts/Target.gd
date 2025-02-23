extends Node2D

@export var colliders : Array[CollisionShape2D]

@export var visualSprite : Node2D
@export var commonScale : Vector2 
@export var expandScale : Vector2

@export var expandTimer : Timer 
@export var dissapearTimer : Timer 

@export var rotSpeed : float
@export var rotMult : float 

var timer : float 

var targetState : TargetStates
enum TargetStates
{
	APPEAR,
	IDLE,
	EXPAND,
	DISAPPEAR
}

func _process(delta: float) -> void:
	match targetState:
		TargetStates.APPEAR:
			pass 
		TargetStates.IDLE:
			pass 
		TargetStates.EXPAND:
			Expand() 
		TargetStates.DISAPPEAR:
			pass
	
	timer += rotSpeed * delta
	rotation = sin(timer) * rotMult

func Expand():
	var t = expandTimer.time_left  / expandTimer.wait_time  
	visualSprite.scale = lerp(expandScale, commonScale, t)
	modulate.a = t

# Locks the player in the target zone 
func LockIn(body: Node2D):
	expandTimer.start()
	targetState = TargetStates.EXPAND 
