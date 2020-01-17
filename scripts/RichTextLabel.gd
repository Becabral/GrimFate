extends RichTextLabel

var dialog
var i = 0

var live = ["Death: Greetings ungrateful mortal! I brought you here to show you how life is selfish and you weren't capable to pay attention. I could have put you in eternal peace but now I only want to extinguish you.", "choice" , "Death: I already made up my mind. I will not kill you. You can go back to life. Ask her to help you when you get too old and debilitated to amuse her"]
var choice_live = ["Why am i here ?","Can i explain myself ?"]

var page = 0
var is_choice = false

func _ready():
	dialog = live
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		check()
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		if get_visible_characters() > get_total_character_count() and dialog[page] == "choice":
			is_choice = false
			i = i + 1
			set_bbcode("Human: \n")
			if i % 2 == 0:
				push_color( Color( 1, 1, 1, 1 )) #white
				append_bbcode(choice_live[0] + "\n")
				pop()
				push_color(Color(0,1,1))
				append_bbcode(choice_live[1])
				pop()
			
			else:
				push_color(Color(0,1,1))
				append_bbcode(choice_live[0] + "\n")
				pop()
				push_color( Color( 1, 1, 1, 1 )) #white
				append_bbcode(choice_live[1])
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
					append_bbcode(choice_live[0] + "\n")
					pop()
					push_color( Color( 1, 1, 1, 1 )) #white
					append_bbcode(choice_live[1])
					pop()
					set_visible_characters(0)
					
				else:
					set_bbcode(dialog[page])
					set_visible_characters(0)


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)

