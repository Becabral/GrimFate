extends Node2D

export var text = ""
var timer
export var wait = 0.1
export var autostart = true 


func _ready():
	var lab = get_node("Label")
	lab.set_text(text)
	if autostart == true:
		play_text()


func play_text():
	yield(get_tree().create_timer(wait), "timeout")
	$FadeIn.play("FadeIn", -1, 0.7)


func _on_OpeningScene_play_narrative():
	play_text()
	pass # Replace with function body.
