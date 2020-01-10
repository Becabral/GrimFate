extends Node2D

#export var animation = ""
export var is_blue = false

func _ready():
	if is_blue:
		$AnimatedSprite.play("fire_blue")
	else:
		$AnimatedSprite.play("")
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
				queue_free()
			else:
				body.blue=true

