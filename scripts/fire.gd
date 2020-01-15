extends Node2D

#export var animation = ""
export var is_blue = false

var fmodevent

func _ready():
	if is_blue:
		$AnimatedSprite.play("fire_blue")
	else:
		$AnimatedSprite.play("")
	
	if has_node("/root/FMOD/FMOD_start"):
		fmodevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Fire", self)
		#get_node("/root/FMOD/FMOD_start").play_one("event:/Fire",self)
		pass
	pass # Replace with function body.

func disableCollision():
	$CollisionShape2D2.disabled=true
	$StaticBody2D/CollisionShape2D.disabled=true
	
func enableCollision():
	$CollisionShape2D2.disabled=false
	$StaticBody2D/CollisionShape2D.disabled=false

func turn_blue():
	is_blue=true
	$AnimatedSprite.play("fire_blue")

func _on_Fire_body_entered(body):
	if body.get_name()=="Player":
		if body.can_dash==false && body.is_flammable:
			body.on_fire=true
			if !is_blue:
				if has_node("/root/FMOD/FMOD_start"):
					get_node("/root/FMOD/FMOD_start").stop_event(fmodevent)
				queue_free()
			else:
				body.blue=true
				
func play_sound(position):
	if has_node("/root/FMOD/FMOD_start"):
		fmodevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Fire", position)
		#get_node("/root/FMOD/FMOD_start").play_one("event:/Fire",position)
		pass

func stop_sound():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").stop_event(fmodevent)

func delete():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").stop_event(fmodevent)
	queue_free()

