extends Node2D
var fire = load("res://scenes/Fire.tscn")
var bigfire = load("res://scenes/BigFire.tscn")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var lit=false
export var blue=false
export var big=false

var fmodevent
#signal lit_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	if lit:
		if big:
			add_child(bigfire.instance())
		else:
			add_child(fire.instance())
		$Fire.stop_sound()
		$Fire.play_sound(self)

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lit:
		if !has_node("Fire"):
			if big:
				add_child(bigfire.instance())
			else:
				add_child(fire.instance())
			$Fire.stop_sound()
			$Fire.play_sound(self)
			#if has_node("/root/FMOD/FMOD_start"):
				#fmodevent=get_node("/root/FMOD/FMOD_start").play_one("event:/Fire", self)
			yield(get_tree().create_timer(0.2), "timeout")
		if blue:
			$Fire.turn_blue()
		 
	else:
		if has_node("Fire"):
			$Fire.delete()
			yield(get_tree().create_timer(0.2), "timeout")
#	pass


func _on_Torch_body_entered(body):
	if body.get_name()=="Player":
		if !body.can_dash && body.is_flammable && !body.blue && lit && !blue: #if flame is red, dashing through will fade it
			lit=false
		elif body.on_fire:
			if body.blue:
				blue=true
			lit=true
