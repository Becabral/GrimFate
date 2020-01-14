extends CanvasLayer


func _ready():
	pass # Replace with function body.


func _on_BtnResume_pressed():
	get_tree().paused = false


func _on_BtnQuit_pressed():
	get_tree().quit()