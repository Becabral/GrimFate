extends Area2D

var touch = false

func _ready():
	$useLbl.hide()
	pass 

func _process(_delta):
	pass

func _on_Lamp_body_entered(body):
	$useLbl.show()
	touch=true

func _on_Lamp_body_exited(body):
	$useLbl.hide()

