extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if type_exists("Fmod"):
		var FMOD = load("res://scenes/FMOD_Start.tscn")
		add_child(FMOD.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset_fmod():
	if(has_node("FMOD_start")):
		$FMOD_start.shutdown()
		#$FMOD_start.queue_free()
		print("shutdown")
#	if type_exists("Fmod"):
#		var FMOD = load("res://scenes/FMOD_Start.tscn")
#		add_child(FMOD.instance())