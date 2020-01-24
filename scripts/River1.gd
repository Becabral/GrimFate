extends Node2D
var begin=false
var voiceevent
var musicevent

func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	$Player/Camera2D.set_offset(Vector2(600,-170))
	$Barco.SPEED = 1.8
	if get_node("/root/SceneChanger").lamp == true:
		$Player/RotPos/AnimatedSprite.play("Player_lateral")
	else:
		$Player/RotPos/AnimatedSprite.play("Player_cinza_lateral")
	if has_node("/root/FMOD/FMOD_start"):
		musicevent=get_node("/root/FMOD/FMOD_start").create_event("event:/River1", $River4)
		voice_narration()
	else:
		$BackupRiver.play()

func _process(_delta):
	
	if get_node("/root/SceneChanger").lamp == true:
		get_node("/root/SceneChanger").lamp = true
		#$Interface/GUI/MarginContainer/MainContainer/Items/ItemLbl.visible = true
		#$Interface/GUI/MarginContainer/MainContainer/Items/Slot0.visible = true
		#$Interface/GUI/MarginContainer/MainContainer/Items/Slot0/Item0/count.visible = false
	if $Barco.position.x >= 2937:
		$Player/Camera2D.current = false
	if $Barco.state == true:
		$Player.barco = true
		$Player.SPEED = 0 
		$Player.position.x = $Barco.position.x - 17
		$Player.position.y = $Barco.position.y - 30 + ($Barco/Sprite.position.y/4)

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			if has_node("/root/FMOD/FMOD_start"):
				get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
				get_node("/root/FMOD/FMOD_start").stop_event(musicevent)
				get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 0)
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial1Entrance.tscn")
	pass # Replace with function body.

func voice_narration():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 1)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 5)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $Narratrive)
		yield(get_tree().create_timer(7.5), "timeout")
		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 6)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $Narratrive)
#		yield(get_tree().create_timer(6), "timeout")
#		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
#		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 7)
#		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $Barco)
#		yield(get_tree().create_timer(9), "timeout")
#		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
#		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 8)
#		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $Barco)
