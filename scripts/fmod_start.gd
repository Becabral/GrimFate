extends Node

func _ready():
	# initialize FMOD
	# initializing with the LIVE_UPDATE flag lets you
	# connect to Godot from the FMOD Studio editor
	# and author events in realtime
	Fmod.system_init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_VOL0_BECOMES_VIRTUAL)

	# load banks
	# place your banks inside the project directory
	Fmod.bank_load("./assets/sound/banks/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.bank_load("./assets/sound/banks/Music.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)

	# register a listener
	Fmod.system_add_listener(self)

	# play some events
	Fmod.play_one_shot("event:/Music", self)

func _process(delta):
	# update FMOD every tick
	# calling system_update also updates the listener 3D position
	# and 3D positions of any attached event instances
	Fmod.system_update()