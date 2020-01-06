extends Node2D
onready var lamp = preload("res://scenes/Lamp.tscn")
#onready var Level1 = preload("res://scenes/Level 1.tscn")
var lampada
	
func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	#inicializa a posição da camera em relação ao personagem
	$Player/Camera2D.offset_v = -4
	$Player/Camera2D.set_offset(Vector2(300,0))
	create_lamp()
	
func _process(_delta):
	#verifica se o personagem está em cima do barco. Se estiver, ele deve parar e o barco andar sozinho
	if $Barco.state == true:
		$Player.barco = true
		$Player.SPEED = 0 
		$Player.position.x = $Barco.position.x - 67
		$Player.position.y = $Barco.position.y - 30
	
	if $Player.lamp == false: # verificador para evitar erro ao testar a lampada já excluída
		if lampada.touch == true and Input.is_action_just_pressed("use"):
			$Player.lamp = true # <- usado para mudar o sprite com a lanterna na mao
			$Fog2.lamp = true
			$Interface/GUI.verifica_incrementa("Lamp")
			lampada.hide()
	else: #If player has lamp, turn the light on
		$Player/Light2D.enabled=true

func create_lamp():
	lampada = lamp.instance()
	lampada.position.x = -165.21
	lampada.position.y = 545.314
	lampada.scale.x = 0.2
	lampada.scale.y = 0.2
	add_child(lampada)
 
func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			$Player.lamp = false
			get_node("/root/SceneChanger").change_scene("res://scenes/River1.tscn")
	pass # Replace with function body.
