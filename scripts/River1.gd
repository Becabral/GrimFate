extends Node2D
func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	$Player/Camera2D.set_offset(Vector2(600,-170))
	$Barco.SPEED = 1.8
	if has_node("/root/FMOD/FMOD_start"):
		#get_node("/root/FMOD/FMOD_start").play_one("event:/Fire", $SoundTest)
		pass

func _process(_delta):
	if get_node("/root/SceneChanger").lamp == true:
		$Player.lamp = true
	if $Barco.position.x >= 2937:
		$Player/Camera2D.current = false
	if $Barco.state == true:
		$Player.barco = true
		$Player.SPEED = 0 
		$Player.position.x = $Barco.position.x - 17
		$Player.position.y = $Barco.position.y - 30

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial1Entrance.tscn")
	pass # Replace with function body.
