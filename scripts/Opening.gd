extends Node2D
var beg= preload("res://scenes/Beginning.tscn").instance()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Beginning/Player/Anim.play("idleright")
	$Beginning/Player.set_physics_process(false)
	$Orb/AnimationPlayer.play("Float")
	$Orb/Camera2D.make_current()
	#$Beginning/Player/Camera2D.current=false
	$AnimationPlayer.play("BringLevelIn")
	yield($AnimationPlayer, "animation_finished")
	#$Beginning/Player/Camera2D.make_current()
	get_tree().get_root().add_child(beg)
	assert(get_tree().change_scene_to(beg)==OK)
	#
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
