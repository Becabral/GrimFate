extends Node2D
onready var beg


export var play=false #Tells me if the Opening can play
var musicevent
var voiceevent
signal play_narrative

#Sets Opening defaults
func _ready():
#	$Beginning/Player/Anim.play("idleright")
#	$Beginning/Player.set_physics_process(false)
#	$Beginning/Fog/Particles2D.emitting=false
	$Orb/AnimationPlayer.play("Float")
	$Orb/Camera2D.make_current()
		
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").set_listener(self)
		musicevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Title", self)
		
#Checks to see if Opening can be played
func _process(_delta):
	if (play):
		play=false
		playOpening()
		

#Brings the level up and changes scene to Beginning
func playOpening():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").set_parameter(musicevent,"PressStart",1)
	emit_signal("play_narrative")
	#$Beginning/Player/Camera2D.current=false
	$AnimationPlayer.play("OrbMoveDown", -1, 0.20)
	
	if has_node("/root/FMOD/FMOD_start"):
		
		yield(get_tree().create_timer(5), "timeout")
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 1)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 0)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $"ParallaxBackground2/Layer 2/Intro_Narrative")
		yield(get_tree().create_timer(2.5), "timeout")
		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 1)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $"ParallaxBackground2/Layer 2/Intro_Narrative2")
		yield(get_tree().create_timer(9.5), "timeout")
		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 2)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $"ParallaxBackground2/Layer 2/Intro_Narrative3")
		yield(get_tree().create_timer(9), "timeout")
		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 3)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", $"ParallaxBackground2/Layer 2/Intro_Narrative4")
	
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("CameraMoveRight")
	$Orb/AnimationPlayer.play("Fade_Player")
	yield($AnimationPlayer, "animation_finished")
	#$Beginning/Player/Camera2D.make_current()
	#get_tree().get_root().add_child(beg)
	#assert(get_tree().change_scene_to(beg)==OK)
	get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 0)
	get_node("/root/SceneChanger").change_scene_slower("res://scenes/Beginning.tscn")
	
