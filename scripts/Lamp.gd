extends Area2D

var touch = false
var pulse = 1
var aux = 1

func _ready():
	$useLbl.hide()
	$LuzAnimation.play("Pulse")

func _process(_delta):
	pass

func _on_Lamp_body_entered(body):
	if body.get_name()=="Player":
		$useLbl.show()
		touch=true

func _on_Lamp_body_exited(body):
	if body.get_name()=="Player":
		touch=false
		$useLbl.hide()
