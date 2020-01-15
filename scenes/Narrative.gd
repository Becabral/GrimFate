extends Node2D

export var text = ""
var timer

func _ready():
	var lab = get_node("Label")
	lab.set_text(text)
	$FadeIn.play("FadeIn", -1, 1)
	
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.5
	timer.connect("timeout", self, "_timeout")
	print("Timed out!")

func _timeout():
	print("Timed out!")