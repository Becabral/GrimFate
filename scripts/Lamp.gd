extends Area2D

var touch = false
var coletado = false

func _ready():
	$useLbl.hide()
	pass 


func _process(_delta):
	if coletado == true:
		#!!!! como fazer para deletar esse item ao inves de esconder o sprite
		#!!!! assim :P
		queue_free()
	else:
		if touch == true:
			coleta()

func _on_Lamp_body_entered(body):
	$useLbl.show()
	touch=true

func _on_Lamp_body_exited(body):
	$useLbl.hide()

func coleta():
	if Input.is_action_just_pressed("use"):
		#touch = false
		coletado = true
		get_node("../Player").lamp = true

