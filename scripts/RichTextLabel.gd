extends RichTextLabel

var dialog
var choice
var i = -1
var a = 0 
onready var global = get_node("/root/SceneChanger")

var live = ["Death: \nGreetings ungrateful mortal! \nI brought you here to show you how life is selfish and you weren't capable to pay attention. \nI could have put you in eternal peace but now I only want to extinguish you.", "choice" , "Death: \nI already made up my mind... I will not kill you... You can go back to life. \nAsk her to help you when you get too old and debilitated to amuse her", "end1"]
var choice_live = ["Why am i here ?","Can i explain myself ?"]

var die
var i_death = ["Greetings my dear mortal!", "I’ve seen you have what it takes to understand what i do." , "I would like to give you the full tour on life but it appears we all have deadlines." , "You see this isn’t a game where you can manipulate your world with rules.", "I brought you here to show you how life is cruel to you and you seem to understand \ntherefore i will make you and offer my dear mortal","Do you want to be like me ? ", "choice" , "end2" ]
var choice_i_death = ["Yes","No"]

var page = 0
var is_choice = false
var choice_made = false

func _ready():
	"""if global.lamp and global.alternative_path:
		dialog = live
	elif global.lamp or global.alternative_path:
		dialog = die
	else:
		dialog = i_death"""
		
	dialog = i_death
	choice = choice_i_death
		
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	get_parent().get_node("AnimationPlayer").play("blink")

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		check()
		a = a + 1
		
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		if get_visible_characters() > get_total_character_count() and dialog[page] == "choice":
			is_choice = false
			i = i + 1
			set_bbcode("Human: \n")
			if i % 2 == 0:
				choice_made = false
				push_color( Color( 1, 1, 1, 1 )) #white
				append_bbcode(choice[0] + "\n")
				pop()
				push_color(Color(0,1,1))
				append_bbcode(choice[1])
				pop()
			
			else:
				choice_made = true
				push_color(Color(0,1,1))
				append_bbcode(choice[0] + "\n")
				pop()
				push_color( Color( 1, 1, 1, 1 )) #white
				append_bbcode(choice[1])
				pop()
			
		
	
func check():
	if is_choice == false:
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size() -1:
				page += 1
				if dialog[page] == "choice":
					is_choice = true
					set_bbcode("Human: \n")
					push_color(Color(0,1,1))
					append_bbcode(choice[0] + "\n")
					pop()
					push_color( Color( 1, 1, 1, 1 )) #white
					append_bbcode(choice[1])
					pop()
					set_visible_characters(0)
					
				elif dialog[page] == "end1":
					print("go to live scene")
				elif dialog[page] == "end2":
					if choice_made:
						print("go to is_death scene")
					else:
						print("go to is_death scene2")
				else:
					set_bbcode(dialog[page])
					set_visible_characters(0)
					
					
					


func _on_Timer_timeout():
	if a % 2 == 0:
		set_visible_characters(get_visible_characters() + 1)
		if get_visible_characters() > get_total_character_count():
			a = a + 1
	else:
		set_visible_characters(get_visible_characters() + get_total_character_count())

		
	
	