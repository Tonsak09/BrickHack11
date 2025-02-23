extends Node2D

@export var sceneToLoadIn : Node2D
@export var sceneToLoadOut : Node2D

@export var loadInHeightOffset : float 

@export var loadInTimer : Timer 

var transState : TransitionState
enum TransitionState 
{
	IDLE,
	LOADING_IN,
	LOADING_OUT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	match transState:
		TransitionState.IDLE:
			pass
		TransitionState.LOADING_IN:
			pass 
		TransitionState.LOADING_OUT:
			pass 

func LoadingIn():
	for child in sceneToLoadIn.get_children():
		if child is Sprite2D:
			
			pass 


func LoadSceneIn():
	loadInTimer.start()
	transState = TransitionState.LOADING_IN
