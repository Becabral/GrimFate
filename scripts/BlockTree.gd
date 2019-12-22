extends KinematicBody2D

var GUI

func _ready():
	GUI=get_parent().get_node("Interface/GUI")

func push(velocity:Vector2):
	move_and_slide(velocity,Vector2())
	
func add():
	GUI.addSeed()