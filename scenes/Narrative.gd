extends Node2D

export var text = ""
var timer
export var wait = 0.1

func _ready():
	var lab = get_node("Label")
	lab.set_text(text)

	
	timer = Timer.new()
	timer.set_wait_time(wait)
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.start()
	

func _on_timer_timeout():
	$FadeIn.play("FadeIn", -1, 1)
	timer.stop()