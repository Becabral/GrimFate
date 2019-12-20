extends Node2D
onready var lamp = preload("res://scenes/Lamp.tscn")
#onready var Level1 = preload("res://scenes/Level 1.tscn")
var lampada

	
func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	create_lamp()
	
	
func _process(delta):
	if $Player.lamp == false: # verificador para evitar erro ao testar a lampada já excluída
		if lampada.touch == true and Input.is_action_just_pressed("use"):
			$Player.lamp = true # <- usado para mudar o sprite com a lanterna na mao
			#gui.lamp = true <- implementar a passagem da variavel para a interface
			lampada.queue_free()
	

func create_lamp():
	lampada = lamp.instance()
	lampada.position.x = 112.21
	lampada.position.y = 545.314
	lampada.scale.x = 0.2
	lampada.scale.y = 0.2
	add_child(lampada)
 


func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/Level 1.tscn")
	pass # Replace with function body.
