@tool
extends Node2D

@export var targets : Array[Sprite2D]
@export var lines : Array[Line2D]


@export var GenerateOutlines: bool:
	set(value):
		GenerateOutlinesNow()

func GenerateOutlinesNow():
	for target in targets:
		var line = Line2D.new()
		add_child(line)
		
