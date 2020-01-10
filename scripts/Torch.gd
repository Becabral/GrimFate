extends Node2D
onready var fire = preload("res://scenes/Fire.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var lit=false
export var blue=false

# Called when the node enters the scene tree for the first time.
func _ready():
	if lit:
		add_child(fire.instance())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		if !has_node("Fire"):
			add_child(fire.instance())
		if blue:
			$Fire.turn_blue()
	else:
		if has_node("Fire"):
			$Fire.queue_free()
			yield(get_tree().create_timer(0.2), "timeout")
#	pass


func _on_Torch_body_entered(body):
	if body.get_name()=="Player":
		if !body.can_dash && body.is_flammable && lit && !blue: #if flame is red, dashing through will fade it
			lit=false
		elif body.on_fire:
			if body.blue:
				blue=true
			lit=true
