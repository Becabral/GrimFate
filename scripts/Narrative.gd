extends Node2D

export var text = ""

func _ready():
	var lab = get_node("Label")
	lab.set_text(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


