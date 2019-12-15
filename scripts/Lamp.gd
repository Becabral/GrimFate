extends Area2D

var touch = false
var coletado = false

func _ready():
	print(touch)
	pass 


func _process(delta):
	if coletado == true:
		#!!!! como fazer para deletar esse item ao inves de esconder o sprite
		$Sprite.hide()
	if touch == true and coletado == false:
		$useLbl.show()
	else:
		$useLbl.hide()

func _on_Lamp_body_entered(body):
	if coletado == false:
		touch = true

func _on_Lamp_body_exited(body):
	if coletado == false:
		touch = false

