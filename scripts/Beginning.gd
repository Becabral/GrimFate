extends Node2D
onready var lamp = preload("res://scenes/Lamp.tscn")
onready var global = get_node("/root/SceneChanger")
#onready var Level1 = preload("res://scenes/Level 1.tscn")
var lampada
var gray=false
	
func _ready():
	global.lamp = true
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	#inicializa a posição da camera em relação ao personagem
	#$Player/Camera2D.offset_v = 0
	$Player/Camera2D.set_offset(Vector2(300,-100))
	
	create_lamp()
	
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").play_one("event:/Music", $FmodSource)
		get_node("/root/FMOD/FMOD_start").play_one("event:/BeginningAmbiance", $FmodSource)
		get_node("/root/FMOD/FMOD_start").play_one("event:/River", $FmodSource)
	else:
		$BackupMusic.play()
		$BackupRiver.play()
	
func _process(_delta):
	if $Player.position.x <= -1780 or $Player.position.x >= 1795:
		$Player/Camera2D.current = false
	else:
		$Player/Camera2D.current = true
	#verifica se o personagem está em cima do barco. Se estiver, ele deve parar e o barco andar sozinho
	if $Barco.state == true:
		$Player.barco = true
		$Player.SPEED = 0 
		$Player.position.x = $Barco.position.x - 17
		$Player.position.y = $Barco.position.y - 30 + ($Barco/Sprite.position.y/4)
		if $Player.lamp == true:
			global.lamp = true
			$Barco/Sprite/lampiao.show()
			$Player/RotPos/AnimatedSprite.play("Player_lateral")
			$Player/LuzLamp.hide()
			$Interface/GUI/MarginContainer2/MainContainer/Items/Slot0.hide()
		else:
			global.lamp = false
	
	if $Player.lamp == false: # verificador para evitar erro ao testar a lampada já excluída
		if lampada.touch == true and Input.is_action_just_pressed("use"):
			#get_node("/root/SceneChanger").lamp = true
			$Player.lamp = true # <- usado para mudar o sprite com a lanterna na mao
			$Fog2.lamp = true
			$Interface/GUI.verifica_incrementa("Lamp")
			lampada.hide()
			get_node("narrative").play_text()
			if has_node("/root/FMOD/FMOD_start"):
				get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine",4)
				get_node("/root/FMOD/FMOD_start").play_one("event:/Voice", $narrative)
			$Player/RotPos/AnimationPlayer.play_backwards("Fade_Gray")

func create_lamp():
	lampada = lamp.instance()
	lampada.position.x = -1345
	lampada.position.y = 529
	lampada.scale.x = 0.15
	lampada.scale.y = 0.15
	add_child(lampada)
 
func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/River1.tscn")
	pass # Replace with function body.


func _on_Fog_entered_fog():
	if !$Player.lamp && !gray:
		gray=true
		$Player/RotPos/AnimationPlayer.play("Fade_Gray",-1,(0.2/3))
	pass
