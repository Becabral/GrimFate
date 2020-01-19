extends RichTextLabel

var dialog
var choice
var i = -1
var a = 0 
onready var global = get_node("/root/SceneChanger")

var live = ["Death:\nGreetings my dear mortal.\nI’ve seen you have what it takes to understand what i do.","Death:\nI would like to give you the full tour but it appears we all have deadlines.","Death:\nYou seem to not understanding at all the importance of my existence, therefore, i will make you go back to your existence knowing i will not embrace you when you cease.", "choice", "live"]
var choice_live = ["Can i make you change your mind?","I prefer that than being like you"]

var die = ["Death:\nGreetings my dear mortal.\nI’ve seen you have what it takes to understand what i do.","Death:\nI would like to give you the full tour but it appears we all have deadlines.","Death:\nI noticed you lack of standards and will do whatever i want just to plase me.","Death:\nI thought you would understand. If you don’t understand what i do, the only thing that remains for you is living forever without being alive at all. Welcome to limbo","choice", "die"]
var choice_die = ["...", "..."]

var i_death = ["Death: \nGreetings my dear mortal. \nI’ve seen you have what it takes to understand what i do.", "Death:\nI would like to give you the full tour but it appears we all have deadlines.","Death:\nYou seem to understand the importance of my existence, therefore, i will make you a proposal you can’t deny.", "choice", "i_death" ]
var choice_i_death = ["Yes","No"]

var page = 0
var is_choice = false
var choice_made = false
var final_reached = false
var count_end = 0

func _ready():
	if global.lamp and global.alternative_path:
		dialog = live
		choice = choice_live
	elif global.lamp or global.alternative_path:
		dialog = die
		choice = choice_die
	else:
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
		is_choice = false
		choice_made = true
		if final_reached == true:
			count_end += 1
			if count_end == 3:
				if global.lamp and global.alternative_path:
					get_node("/root/SceneChanger").change_scene_slow("res://scenes/Live.tscn")
				elif global.lamp or global.alternative_path:
					get_node("/root/SceneChanger").change_scene_slow("res://scenes/Die.tscn")
				else:
					get_node("/root/SceneChanger").change_scene_slow("res://scenes/i_death.tscn")
					
			
		
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		if get_visible_characters() > get_total_character_count() and dialog[page] == "choice":
			is_choice = false
			i = i + 1
			if dialog == i_death:
				set_bbcode("Death: Do you want to do what i do?\nHuman: \n")
			else:
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
					if dialog == i_death:
						set_bbcode("Death: Do you want to do what i do?\nHuman: \n")
					else:
						set_bbcode("Human: \n")
						
					push_color(Color(0,1,1))
					append_bbcode(choice[0] + "\n")
					pop()
					push_color( Color( 1, 1, 1, 1 )) #white
					append_bbcode(choice[1])
					pop()
					set_visible_characters(0)
					
				elif dialog[page] == "live":
					if choice_made or !choice_made:
						set_bbcode("Farewell ignorant human! i hope you’ll enjoy the time you have left")
						final_reached = true
				elif dialog[page] == "i_death":
					if choice_made:
						set_bbcode("Death:\nVery well! Welcome my dear friend.\nI knew you would understand me. Your finest moments are yet to come.")
						set_visible_characters(0)
						final_reached = true	
					else:
						set_bbcode("Death:\nNo?! Why ?!\nI thought you would understand.\nIf no one can understand me i will leave you. Good luck trying to balance life without me. ")
						set_visible_characters(0)
						final_reached = true	
				elif dialog[page] == "die":
					if choice_made or !choice_made:
						set_bbcode("Farewell ignorant human!")
						final_reached = true
				else:
					set_bbcode(dialog[page])
					set_visible_characters(0)		
					
					


func _on_Timer_timeout():
	if a % 2 == 0:
		set_visible_characters(get_visible_characters() + 1)
		if get_visible_characters() > get_total_character_count():
			a = a + 1
			count_end += 1
	else:
		set_visible_characters(get_visible_characters() + get_total_character_count())
		
			

		
	
	