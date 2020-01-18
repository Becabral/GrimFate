extends Node2D

var scene = load("res://scenes/Grims_End_Dialog.tscn")
var scene_instance = scene.instance()

func _ready():
	$brilho/AnimationPlayer.play("Rotate")
	$Player.has_hood=true
	$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")

func _on_CutsceneTrigger_body_entered(body):
	if body.get_name()=="Player":
		$Player.set_physics_process(false)
		$Player.anim_switch("idle")
		$Player/RotPos/AnimatedSprite.play("Player_cloak_costas")
		$Player/Anim.play("idleup")
		$Player/Camera2D/AnimPlayerCamera.play("CameraPan")
		yield($Player/Camera2D/AnimPlayerCamera, "animation_finished")
		scene_instance.set_name("scene")
		$ParallaxBackground.add_child(scene_instance)
	pass # Replace with function body.

		


		
	pass # Replace with function body.
