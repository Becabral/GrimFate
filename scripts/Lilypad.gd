extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LilyArea_body_entered(body):
	if body.get_name()=="Player":
		body.set_collision_mask_bit( 1, false)
		body.set_collision_layer_bit( 1, false)
	pass # Replace with function body.



func _on_LilyArea_body_exited(body):
	if body.get_name()=="Player":
		body.set_collision_mask_bit( 1, true)
		body.set_collision_layer_bit( 1, true)
	pass # Replace with function body.
