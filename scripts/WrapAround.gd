extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var warp_to = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WrapAroundR_body_entered(body):
	if body.get_name()=="Player":
		#body.get_node("Camera2D").smoothing_enabled=false
		body.position.x=warp_to
#		yield(get_tree().create_timer(0.2), "timeout")
#		body.get_node("Camera2D").smoothing_enabled=true
		
	pass # Replace with function body.
