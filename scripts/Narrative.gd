extends Node2D

export var text = ""
var timer
export var wait = 0.1

func _ready():
	var lab = get_node("Label")
	lab.set_text(text)

	
	
#	timer = Timer.new()
#	timer.set_wait_time(wait)
#	timer.connect("timeout",self,"_on_timer_timeout") 
#	add_child(timer)
#	timer.start()

func play_text():
	yield(get_tree().create_timer(wait), "timeout")
	$FadeIn.play("FadeIn", -1, 0.7)
#
#func _on_timer_timeout():
#	$FadeIn.play("FadeIn", -1, 1)
#	timer.stop()

func _on_OpeningScene_play_narrative():
	play_text()
	pass # Replace with function body.
