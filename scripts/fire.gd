extends Node2D

#export var animation = ""
export var is_blue = false

func _ready():
	if is_blue:
		$AnimatedSprite.play("fire_blue")
	else:
		$AnimatedSprite.play("")
	pass # Replace with function body.



func _on_Fire_body_entered(body):
	if body.get_name()=="Player":
		if body.can_dash==false && !is_blue:
			body.on_fire=true
			queue_free()

