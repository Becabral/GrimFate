extends Area2D

var touch = false

func _ready():
	$useLbl.hide()
	pass 

func _process(_delta):
	if touch and Input.is_action_just_pressed("use"):
		get_parent().get_node("Interface/GUI").addSeed()
		queue_free()

func _on_Seed_body_entered(body):
	if body.get_name()=="Player":
		$useLbl.show()
		touch=true

func _on_Seed_body_exited(body):
	if body.get_name()=="Player":
		$useLbl.hide()
		touch = false
