extends RichTextLabel

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
						set_bbcode("Farewell ignorant human!")
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
		
			

		
	
	