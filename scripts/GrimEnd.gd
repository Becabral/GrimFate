extends Node2D

func _on_CutsceneTrigger_body_entered(body):
	if body.get_name()=="Player":
		$Player.set_physics_process(false)
		$Player.anim_switch("idle")
		$Player/Camera2D/AnimPlayerCamera.play("CameraPan")
	pass # Replace with function body.

		