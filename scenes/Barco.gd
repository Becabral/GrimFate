extends Area2D
var state = false
var SPEED = 1.5
var move = 0

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if state == true:
		move = 1
	position = position + Vector2(move, 0) * SPEED

func _on_Barco_body_entered(body):
	print("entrou")
	if body.get_name()=="Player":
		print("no barco")
		state = true
