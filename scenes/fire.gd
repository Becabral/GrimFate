extends Node2D

export var animation = ""

func _ready():
	$AnimatedSprite.play(animation)
	pass # Replace with function body.

