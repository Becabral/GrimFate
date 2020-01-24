extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skip=false
# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").set_listener(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if((Input.is_action_pressed("ui_accept") or Input.is_action_pressed("use"))  && !skip):
		skip=true
		$AnimationPlayer.play("FadeEnding")
		yield($AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(3), "timeout")
		get_node("/root/SceneChanger").change_scene_slow("res://scenes/Title.tscn")
#	pass
