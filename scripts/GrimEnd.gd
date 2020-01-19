extends Node2D

var scene = load("res://scenes/Grims_End_Dialog.tscn")
var scene_instance = scene.instance()
var gray_count = 0
var trigger=false

signal kill_fires

signal kill_players

func _ready():
	$brilho/AnimationPlayer.play("Rotate")
	$Player.has_hood=true
	$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
	$Interface/GUI.adiciona_skill("Dash")
	
func _process(_delta):
	$Player/Camera2D.position.x=0
	

func _on_CutsceneTrigger_body_entered(body):
	if body.get_name()=="Player":
		if !trigger:
			trigger=true
			$Player.barco=true
			$Player.anim_switch("idle")
			$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
			$Player/Anim.play("idleup")
			$Player/Camera2D/AnimPlayerCamera.play("CameraPan")
			yield($Player/Camera2D/AnimPlayerCamera, "animation_finished")
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
