extends Node2D
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
		#get_node("/root/FMOD/FMOD_start").play_one("event:/Fire", $SoundTest)
		pass

func _process(_delta):

	if get_node("/root/SceneChanger").lamp == true:
		get_node("/root/SceneChanger").lamp = true
		$Interface/GUI/MarginContainer/MainContainer/Items/ItemLbl.visible = true
		$Interface/GUI/MarginContainer/MainContainer/Items/Slot0.visible = true
		$Interface/GUI/MarginContainer/MainContainer/Items/Slot0/Item0/count.visible = false
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
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial1Entrance.tscn")
	pass # Replace with function body.
