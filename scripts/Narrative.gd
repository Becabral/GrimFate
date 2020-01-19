extends Node2D

export var text = ""
var timer
export var wait = 0.1
export var autostart = true
export var size_x = 555
export var size_y = 178 
export var font_size = 32

var play_once = true

func _ready():
	var lab = get_node("Label")
	lab.set_text(text)
	$Label.margin_right = size_x
	$Label.margin_bottom = size_y
	$Label.get_font('font').size = font_size
	if autostart == true:
		play_text()


func play_text():
	yield(get_tree().create_timer(wait), "timeout")
	$FadeIn.play("FadeIn", -1, 0.7)

func play_text_backwards():
	$FadeIn.play_backwards("FadeIn")

func _on_OpeningScene_play_narrative():
	play_text()
	pass # Replace with function body.


func _on_BigTorch_body_entered(body):
	if play_once == true:
		play_text_backwards()
		play_once = false


func _on_DoorEvent2_open():
		play_text_backwards()


func _on_BigTorch_went_off():
	play_text()
	pass # Replace with function body.
