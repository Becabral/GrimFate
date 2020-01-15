extends CanvasLayer


func _ready():
	$Container.hide()
	pass # Replace with function body.


func _on_BtnResume_pressed():
	get_tree().paused = false


func _on_BtnQuit_pressed():
	get_tree().quit()