extends Node2D
onready var lamp = preload("res://scenes/Lamp.tscn")
onready var seeds = preload("res://scenes/Seed.tscn")

var lampada
var semente = []

var seedCount = 4 #contador de sementes para evitar erro de testar instancias inexistentes

func _ready():
	create_lamp()
	create_seed()
	
func _process(_delta):
	if $Player.lamp == false: # verificador para evitar erro ao testar a lampada já excluída
		if lampada.touch == true and Input.is_action_just_pressed("use"):
			$Player.lamp = true # <- usado para mudar o sprite com a lanterna na mao
			$Interface/GUI.verifica_incrementa("Lamp")
			lampada.queue_free()
		
#	if seedCount>0:
#		for i in range(seedCount):
#			print(i)
#			if semente[i]:
#				if semente[i].touch == true and Input.is_action_just_pressed("use"): # !!! solucionar esse erro !!!
#
#					$Interface/GUI.verifica_incrementa("Seed")
#					seedCount -= 1
#					var erase = semente[i]
#					semente.erase(i)
#					erase.queue_free()
#					break


func _on_Area2D_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/GrimEnd.tscn")


func create_lamp():
	lampada = lamp.instance()
	lampada.position.x = 300
	lampada.position.y = 88
	lampada.scale.x = 0.2
	lampada.scale.y = 0.2
	add_child(lampada)
	
func create_seed():
	for i in range (4): 
		semente.append(seeds.instance())
		semente[i].position.x = 450 + i*60
		semente[i].position.y = 60 + i*60
		semente[i].scale.x = 0.2
		semente[i].scale.y = 0.2
		add_child(semente[i])