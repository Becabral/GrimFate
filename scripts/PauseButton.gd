extends CanvasLayer
var isPaused = false
func _ready():
	pass # Replace with function body.


func _on_btnPause_pressed():
	isPaused = true
	if has_node("/root/FMOD/FMOD_start"):
			get_node("/root/FMOD/FMOD_start").pause()
