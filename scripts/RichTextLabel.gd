extends RichTextLabel

var dialog

var die = ["Então Alfredo! Como vai o dia?" , "Cá vamos andando"]
var live = ["Então Alfredo! Como vai o dia?" , "Cá vamos andando"]
var death_bestie = ["Então Alfredo! Como vai o dia?" , "Cá vamos andando"]

var page = 0


func _ready():
	dialog = live
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event):
	if Input.is_action_just_pressed("use"):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size() -1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
