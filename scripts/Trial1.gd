extends Node2D
#onready var Level2 = preload("res://scenes/Level 2.tscn")
signal kill_fires
var outside=false

func _ready():
	$Player/Camera2D.drag_margin_h_enabled=false
	$Player/RotPos/AnimatedSprite.play("Player_costas")
	pass 

func _process(_delta):
#	if $Player.position.x >= 269 and $Player.position.x <= 717 and $Player.position.y <= -360:
#			$Player/Camera2D.current = false
#	else:
#		$Player/Camera2D.current = true
	if Input.is_action_just_pressed("0"):
		$Player.position=Vector2(480, 500)
#	if $Player.has_hood == false and Input.is_action_just_pressed("use"):
#		$Interface/GUI.adiciona_skill("Dash")

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		emit_signal("kill_fires")
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/River2.tscn")
	pass # Replace with function body.


func _on_SmoothOff_body_entered(body):
	if body.get_name()=="Player":
		if !outside:
			$Player/Camera2D.smoothing_speed=35
			yield(get_tree().create_timer(0.3), "timeout")
			$Player/Camera2D.smoothing_enabled=false
			$Player/Camera2D.limit_top=(-2595)
			$Player/Camera2D.limit_bottom=(-1400)
			$AnimCanvas.play("FadeCanvasIn")
			outside=true
	pass # Replace with function body.


func _on_SmoothOn_body_entered(body):
	if body.get_name()=="Player":
		if outside:
			$Player/Camera2D.smoothing_enabled=true
			$Player/Camera2D.smoothing_speed=5
			$Player/Camera2D.limit_top=-10000000
			$Player/Camera2D.limit_bottom=10000000
			$AnimCanvas.play("FadeCanvasOut")
			
			outside=false
	pass # Replace with function body.
