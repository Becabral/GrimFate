extends Node2D
#onready var Level2 = preload("res://scenes/Level 2.tscn")

func _ready():
	$Player/Camera2D.drag_margin_h_enabled=false
	pass 

#func _process(_delta):
#	if $Player.has_hood == false and Input.is_action_just_pressed("use"):
#		$Interface/GUI.adiciona_skill("Dash")

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/River2.tscn")
	pass # Replace with function body.


func _on_SmoothOff_body_entered(body):
	if body.get_name()=="Player":
		$Player/Camera2D.smoothing_speed=35
		yield(get_tree().create_timer(0.3), "timeout")
		$Player/Camera2D.smoothing_enabled=false
	pass # Replace with function body.


func _on_SmoothOn_body_entered(body):
	if body.get_name()=="Player":
		$Player/Camera2D.smoothing_enabled=true
		$Player/Camera2D.smoothing_speed=5
	pass # Replace with function body.
