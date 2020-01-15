extends Node

#var has_listener=false

func _ready():
	# initialize FMOD
	# initializing with the LIVE_UPDATE flag lets you
	# connect to Godot from the FMOD Studio editor
	# and author events in realtime
	

	Fmod.system_init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_VOL0_BECOMES_VIRTUAL)
	
		# load banks
		# place your banks inside the project directory
	Fmod.bank_load("./assets/sound/banks/Desktop/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Desktop/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Desktop/Music.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Desktop/Beginning.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Desktop/Trial1.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		
	#Fmod.system_add_listener(get_node("/Beginning/Player"))
	#Fmod.play_one_shot("event:/Music", $FmodSource)
	
		# register a listener
	# play some events

func _process(_delta):
	# update FMOD every tick
	# calling system_update also updates the listener 3D position
	# and 3D positions of any attached event instances
	#if has_listener:
	Fmod.system_update()
	
func play_one(event,source):
	Fmod.play_one_shot_attached(event,source)
	
func create_event(event, node):
	var my_music_event = Fmod.create_event_instance(event)
	Fmod.attach_instance_to_node( my_music_event, node )
	Fmod.event_start(my_music_event)
	return my_music_event
	
func stop_event(event):
	Fmod.event_stop(event, Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	Fmod.event_release(event)
		
func set_listener(listener):
	Fmod.system_add_listener(listener)
	#has_listener=true
