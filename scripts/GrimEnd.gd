extends Node2D

var scene = load("res://scenes/Grims_End_Dialog.tscn")
var scene_instance = scene.instance()

func _on_CutsceneTrigger_body_entered(body):
	if body.get_name()=="Player":
		$Player.set_physics_process(false)
		$Player.anim_switch("idle")
		$Player/Camera2D/AnimPlayerCamera.play("CameraPan")
		scene_instance.set_name("scene")
		$ParallaxBackground.add_child(scene_instance)
	pass # Replace with function body.

		