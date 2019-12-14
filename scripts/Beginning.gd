extends Node2D


func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	
func _process(delta):
	if $Lamp.touch == true:
		coleta()

func coleta():
	# !!!! tentar melhorar esse script (ver Lamp script) !!!! 
	if Input.is_action_just_pressed("use"):
		$Lamp.touch = false
		$Lamp.coletado = true
		$Player.lamp = true

