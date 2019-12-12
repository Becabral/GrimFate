extends Node2D

func _ready():
	#initializes character state and face direction
	get_node("Player").STATE = "sideView"
	get_node("Player").spritedir = "right"


#func _process(delta):
#	pass
