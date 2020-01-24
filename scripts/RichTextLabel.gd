extends RichTextLabel

var voiceevent
var dialog
var choice
var i = -1
var a = 0 
onready var global = get_node("/root/SceneChanger")

var live = ["Death:\nGreetings, dear mortal. \nYour round of trials is now at its end.","Death:\nI would have liked to give you the full tour but it appears we all have deadlines.","Death:\nIt seems you elect to ignore the meaning behind my existence. You shall have your way.","In time, I will return you to your existence.","But know this. \nNext time you perish, I shall not be there to embrace you.", "choice", "live"]
var choice_live = ["Your words mean nothing to me. Return me at once.","Is there a way for you to reconsider?"]

var die = ["Death:\nGreetings, dear mortal.\nYour round of trials is now at its end.","Death:\nI would have liked to give you the full tour but it appears we all have deadlines.","Death:\nYou have struggled. The meaning of all this still eludes you.","die_dual","choice", "die"]
var choice_die = ["...", "..."]

var i_death = ["Death:\nGreetings, dear mortal.\nYour round of trials is now at its end.","Death:\nI would have liked to give you the full tour but it appears we all have deadlines.","Death:\nI’m pleased to see that you seem to understand the importance of my existence. Therefore, I shall make you a proposal.\nOne which you cannot deny.", "choice", "i_death" ]
var choice_i_death = ["Yes","No"]

var page = 0
var is_choice = false
var no_choice = false
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
	
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 1)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", 7)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", self)
		yield(get_tree().create_timer(7.5), "timeout")
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 0)

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		if no_choice == false:
			choice_made = true
		check()
		a = a + 1
		is_choice = false
		if page == 1 && a == 2:
				play_sound(8,7.5)
		if page == 2 && a == 4 && dialog==i_death:
				play_sound(9,7.5)
		if page == 3 && a == 6 && dialog==i_death:
				play_sound(10,7.5)
		if page == 4 && a == 8 && dialog==i_death && count_end!=3:
				if choice_made:
					play_sound(11,7.5)
				else:
					play_sound(12,7.5)
					
		if page == 2 && a == 4 && dialog==live:
				play_sound(13,7.5)
		if page == 3 && a == 6 && dialog==live:
				play_sound(14,7.5)
		if page == 4 && a == 8 && dialog==live:
				play_sound(15,7.5)
		if page == 6 && a == 12 && dialog==live:
				play_sound(16,7.5)
		
		if page == 2 && a == 4 && dialog==die:
				play_sound(17,7.5)
		if page == 3 && a == 6 && dialog==die:
			if global.alternative_path == true:
				play_sound(18,7.5)
				yield(get_tree().create_timer(5.5), "timeout")
				play_sound(20,7.5)
			elif global.lamp==true:
				play_sound(19,7.5)
				yield(get_tree().create_timer(7), "timeout")
				play_sound(20,7.5)
		if page == 5 && a == 10 && dialog==die:
				play_sound(21,7.5)
				
		if final_reached == true:
			count_end += 1	
			if count_end == 3:
				if has_node("/root/FMOD/FMOD_start"):
					get_node("/root/FMOD/FMOD_start").set_parameter(get_node("/root/GrimEnd").musicevent,"EndSection",4)
				if global.lamp and global.alternative_path:
					get_node("/root/SceneChanger").change_scene_slow("res://scenes/Live.tscn")
				elif global.lamp or global.alternative_path:
					get_node("/root/SceneChanger").change_scene_slow("res://scenes/Die.tscn")
				else:
					if choice_made == true:
						get_node("/root/SceneChanger").change_scene_slow("res://scenes/i_death.tscn")
					else:
						get_node("/root/SceneChanger").change_scene_slow("res://scenes/Die.tscn")
			
		
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		if get_visible_characters() > get_total_character_count() and dialog[page] == "choice":
			is_choice = false
			no_choice = true
			i = i + 1
			if dialog == i_death:
				set_bbcode("Since you have proven to have the makings, will you take on the mantle of Death?\nHuman: \n")
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
						set_bbcode("Since you have proven to have the makings, will you take on the mantle of Death?\nHuman: \n")
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
						set_bbcode("Farewell ignorant being! Enjoy the time you have left.")
						final_reached = true
				elif dialog[page] == "i_death":
					if choice_made:
						set_bbcode("Death:\nVery well! Welcome my dear friend.\nYour finest moments are yet to come.")
						set_visible_characters(0)
						final_reached = true	
					else:
						set_bbcode("Death:\n...I see. You deny my role even though you understand it. Clearly, you must find no place for it to continue. Very well then. I shall take my leave and withdraw from my duties. Remain here and lay witness to how valuable your deathless world really is.")
						set_visible_characters(0)
						final_reached = true	
				elif dialog[page] == "die":
					if choice_made or !choice_made:
						set_bbcode("Farewell ignorant being!")
						final_reached = true
				elif dialog[page] == "die_dual":
					if global.lamp == true:
						set_bbcode("Death:\nYou kept hold of your essence, yet were still compelled to ford through my trials.\nOne who knows not the road they travel shall remain lost in limbo. Living forever without being alive at all.")
						set_visible_characters(0)
					elif global.alternative_path == true:
						set_bbcode("Death:\nYou strayed from your path yet were unable to keep your essence.\nOne who knows not the road they travel shall remain lost in limbo. Living forever without being alive at all.")
						set_visible_characters(0)
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
			

func play_sound(line, time):
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").stop_event(voiceevent)
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 1)
		get_node("/root/FMOD/FMOD_start").system_parameter("CurrentLine", line)
		voiceevent=get_node("/root/FMOD/FMOD_start").create_event("event:/Voice", self)
		yield(get_tree().create_timer(time), "timeout")
		get_node("/root/FMOD/FMOD_start").system_parameter("VoiceFade", 0)
	
	