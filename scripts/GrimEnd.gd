extends Node2D

var scene = load("res://scenes/Grims_End_Dialog.tscn")
var scene_instance = scene.instance()
var gray_count = 0
var trigger=false
var musicevent

signal kill_fires

signal kill_players

func _ready():
	$brilho/AnimationPlayer.play("Rotate")
	$Player.has_hood=true
	$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
	$Interface/GUI.adiciona_skill("Dash")
	
	if has_node("/root/FMOD/FMOD_start"):
		musicevent=get_node("/root/FMOD/FMOD_start").create_event("event:/End", get_node("/root/FMOD"))
	else:
		$BackupMusic.play()
	
func _process(_delta):
	$Player/Camera2D.position.x=0
	

func _on_CutsceneTrigger_body_entered(body):
	if body.get_name()=="Player":
		if !trigger:
			trigger=true
			if has_node("/root/FMOD/FMOD_start"):
				get_node("/root/FMOD/FMOD_start").set_parameter(musicevent,"EndSection",3)
			
			$Player.barco=true
			$Player.anim_switch("idle")
			$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
			$Player/Anim.play("idleup")
			$Player/Camera2D/AnimPlayerCamera.play("CameraPan")
			yield($Player/Camera2D/AnimPlayerCamera, "animation_finished")
			yield(get_tree().create_timer(1.5), "timeout")
			scene_instance.set_name("scene")
			$ParallaxBackground.add_child(scene_instance)
			emit_signal("kill_players")
			emit_signal("kill_fires")
			
	pass # Replace with function body.
	
	
func kill_all():
	for i in range(0, get_child_count()):
		print(i)
		yield(get_tree().create_timer(1), "timeout")
		get_child(0).queue_free()


func _on_EndFireSpawner_body_entered(body):
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").set_parameter(musicevent,"EndSection",1)
	pass # Replace with function body.


func _on_EndFireSpawner2_body_entered(body):
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").set_parameter(musicevent,"EndSection",2)
	pass # Replace with function body.
