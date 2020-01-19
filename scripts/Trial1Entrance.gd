extends Node2D

var movinganimation = false

func _ready():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").play_one("event:/River1Entrance", $Sound)
	
	# inicializa o personagem com o estado e a direção pra onde olha
	$CanvasLayer2/Player.STATE = "sideView"
	$CanvasLayer2/Player.spritedir = "right"
	$CanvasLayer2/Player/Camera2D.set_offset(Vector2(600,-130))
	$CanvasLayer2/Player/Camera2D.limit_left=0
	$CanvasLayer2/Player/Camera2D.limit_right=515
	$CanvasLayer2/Player/Camera2D.limit_top=60
	if get_node("/root/SceneChanger").lamp == true:
		$CanvasLayer2/Player/RotPos/AnimatedSprite.play("Player_lateral")
	else:
		$CanvasLayer2/Player/RotPos/AnimatedSprite.play("Player_cinza_lateral")
	
	$CanvasLayer2/Barco.SPEED = 1

func _process(_delta):
	if $CanvasLayer2/Barco.position.x >= 400:
		$CanvasLayer2/Barco.SPEED=0
		$AnimationPlayer.play("Player entering")
		movinganimation=true
	if $CanvasLayer2/Barco.state == true && !movinganimation:
		$CanvasLayer2/Player.barco = true
		$CanvasLayer2/Player.SPEED = 0 
		$CanvasLayer2/Player.position.x = $CanvasLayer2/Barco.position.x - 17
		$CanvasLayer2/Player.position.y = $CanvasLayer2/Barco.position.y - 30 + ($CanvasLayer2/Barco/Sprite.position.y/4)

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial1.tscn")
	pass # Replace with function body.
