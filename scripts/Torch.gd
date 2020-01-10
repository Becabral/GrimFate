extends Node2D
onready var fire = preload("res://scenes/Fire.tscn")
onready var bigfire = preload("res://scenes/BigFire.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var lit=false
export var blue=false
export var big=false


# Called when the node enters the scene tree for the first time.
func _ready():
	if lit:
		if big:
			add_child(bigfire.instance())
		else:
			add_child(fire.instance())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		if !has_node("Fire"):
			if big:
				add_child(bigfire.instance())
			else:
				add_child(fire.instance())
		if blue:
			$Fire.turn_blue()
	else:
		if has_node("Fire"):
			$Fire.queue_free()
			print("deleted fire")
			yield(get_tree().create_timer(0.2), "timeout")
#	pass


func _on_Torch_body_entered(body):
	if body.get_name()=="Player":
		print("player entered torch")
		if !body.can_dash && body.is_flammable && !body.blue && lit && !blue: #if flame is red, dashing through will fade it
			lit=false
			print("unlit")
		elif body.on_fire:
			if body.blue:
				blue=true
			lit=true
