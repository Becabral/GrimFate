extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if type_exists("Fmod"):
		print("Fmod exists")
		var FMOD = load("res://scenes/FMOD_Start.tscn")
		add_child(FMOD.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
