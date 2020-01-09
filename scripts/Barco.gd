extends Area2D
var state = false
var SPEED = 1.5
var move = 0

func _ready():
	$Anim.play("position")

func _physics_process(_delta):
	if state == true:
		move = 1
	position = position + Vector2(move, 0) * SPEED

func _on_Barco_body_entered(body):
	if body.get_name()=="Player":
		state = true
