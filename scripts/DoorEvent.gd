extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_node("TorchC") and has_node("TorchD"):
		if $TorchC.lit and $TorchD.lit and has_node("Door"):
			$Door.queue_free()
	
	if has_node("BigTorch"):
		if $BigTorch.blue and $BigTorch.lit and has_node("Door"):
			$Door.queue_free()
#	pass