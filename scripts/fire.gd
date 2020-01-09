extends Node2D

#export var animation = ""
export var is_blue = false

func _ready():
	if is_blue:
		$AnimatedSprite.play("fire_blue")
	else:
		$AnimatedSprite.play("")
	pass # Replace with function body.

