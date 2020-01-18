extends Node2D

var movinganimation = false

func _ready():
	# inicializa o personagem com o estado e a direção pra onde olha
	$Player.STATE = "sideView"
	$Player.spritedir = "right"
	$Player/Camera2D.set_offset(Vector2(600,-130))
	$Player/Camera2D.limit_left=0
	$Player/Camera2D.limit_right=515
	$Player/Camera2D.limit_top=60
	if get_node("/root/SceneChanger").lamp == true:
		$Player/RotPos/AnimatedSprite.play("Player_lateral")
	else:
		$Player/RotPos/AnimatedSprite.play("Player_cinza_lateral")
	
	$Barco.SPEED = 1.8

func _process(_delta):
	if $Barco.position.x >= 400:
		$Barco.SPEED=0
		$AnimationPlayer.play("Player entering")
		movinganimation=true
	if $Barco.state == true && !movinganimation:
		$Player.barco = true
		$Player.SPEED = 0 
		$Player.position.x = $Barco.position.x - 17
		$Player.position.y = $Barco.position.y - 30 + ($Barco/Sprite.position.y/4)

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial1.tscn")
	pass # Replace with function body.
