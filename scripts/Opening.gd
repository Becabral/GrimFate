extends Node2D
onready var beg


var play=true #Tells me if the Opening can play

#Sets Opening defaults
func _ready():
	beg = preload("res://scenes/Beginning.tscn")
	$Beginning/Player/Anim.play("idleright")
	$Beginning/Player.set_physics_process(false)
	$Beginning/Fog/Particles2D.emitting=false
	$Orb/AnimationPlayer.play("Float")
	$Orb/Camera2D.make_current()
		
#Checks to see if Opening can be played
func _process(_delta):
	if (play):
		play=false
		playOpening()

#Brings the level up and changes scene to Beginning
func playOpening():
	#$Beginning/Player/Camera2D.current=false
	$AnimationPlayer.play("BringLevelIn")
	yield($AnimationPlayer, "animation_finished")
	#$Beginning/Player/Camera2D.make_current()
	#get_tree().get_root().add_child(beg)
	#assert(get_tree().change_scene_to(beg)==OK)
	assert(get_tree().change_scene_to(beg)==OK)
	
