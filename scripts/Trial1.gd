extends Node2D
#onready var Level2 = preload("res://scenes/Level 2.tscn")
signal kill_fires
export var bypassTrial2 = false
var outside= false
var melted = false
var secret = false
var windsound
onready var global = get_node("/root/SceneChanger")

func _ready():
	$Player/FlameParticle.show()
	$Player/Camera2D.drag_margin_h_enabled=false
	if global.lamp == true:
		$Player/RotPos/AnimatedSprite.play("Player_costas")
	else:
		$Player/RotPos/AnimatedSprite.play("Player_cinza_costas")
	
	pass
	
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").play_one("event:/Trial1", self)
		windsound=get_node("/root/FMOD/FMOD_start").create_event("event:/Wind", $Snow)
	else:
		$BackupMusic.play()
		$BackupWind.play()

func _process(_delta):
#	if $Player.position.x >= 269 and $Player.position.x <= 717 and $Player.position.y <= -360:
#			$Player/Camera2D.current = false
#	else:
#		$Player/Camera2D.current = true
	if Input.is_action_just_pressed("0"):
		$Player.position=Vector2(480, 500)
#	if $Player.has_hood == false and Input.is_action_just_pressed("use"):
#		$Interface/GUI.adiciona_skill("Dash")
	if $Torches/SecretTorch.lit && !secret :
		secret=true
		$Player.SPEED=0
		$Player.set_physics_process(false)
		global.alternative_path = true
		if global.lamp == true:
			$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
		else:
			$Player/RotPos/AnimatedSprite.play("Player_cinza_cloak_costas")
		$Player/Camera2D/AnimPlayerCamera.play("CameraPanHigher")
		yield($Player/Camera2D/AnimPlayerCamera, "animation_finished")
		yield(get_tree().create_timer(1), "timeout")
		$Torches/SnowmanTorch.lit=true
		yield(get_tree().create_timer(2), "timeout")
		if(bypassTrial2):
			global.change_scene_slow("res://scenes/GrimEnd.tscn")
		else: global.change_scene_slow("res://scenes/River2.tscn")
		
		
	if secret:
		$Player.SPEED=0
		$Player.barco = true
		if global.lamp == true:
			$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
		else:
			$Player/RotPos/AnimatedSprite.play("Player_cinza_cloak_costas")

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/FMOD/FMOD_start"):
			get_node("/root/FMOD/FMOD_start").stop_event(windsound)
		emit_signal("kill_fires")
		if has_node("/root/SceneChanger"):
			if bypassTrial2:
				get_node("/root/SceneChanger").change_scene("res://scenes/GrimEnd.tscn")
			else:
				get_node("/root/SceneChanger").change_scene("res://scenes/River2.tscn")
	pass # Replace with function body.


func _on_SmoothOff_body_entered(body):
	if body.get_name()=="Player":
		if !outside:
			if has_node("/root/FMOD/FMOD_start"):
				get_node("/root/FMOD/FMOD_start").set_parameter(windsound,"Inside",0)
			$Player/Camera2D.smoothing_speed=35
			yield(get_tree().create_timer(0.3), "timeout")
			$Player/Camera2D.smoothing_enabled=false
			$Player/Camera2D.limit_top=(-2595)
			$Player/Camera2D.limit_bottom=(-1400)
			#$AnimCanvas.play("FadeCanvasIn")
			$Hider.hide()
			#$Snow.show()
			outside=true
			
	pass # Replace with function body.


func _on_SmoothOn_body_entered(body):
	if body.get_name()=="Player":
		if outside:
			$Player/Camera2D.smoothing_enabled=true
			$Player/Camera2D.smoothing_speed=5
			$Player/Camera2D.limit_top=-10000000
			$Player/Camera2D.limit_bottom=10000000
			if has_node("/root/FMOD/FMOD_start"):
				get_node("/root/FMOD/FMOD_start").set_parameter(windsound,"Inside",1)
			#$AnimCanvas.play("FadeCanvasOut")
			$Hider.show()
			#$Snow.hide()
			outside=false
	pass # Replace with function body.


func _on_SnowWallArea_body_entered(body):
	if body.get_name()=="Player":
		if body.on_fire && !melted:
			$SnowWall/AnimSnowWall.play("Melt")
			melted=true
	pass # Replace with function body.
