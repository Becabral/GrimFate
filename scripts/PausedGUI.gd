extends CanvasLayer


func _ready():
	$Container.hide()
	$Fundo.hide()
	$BG.hide()
	$Container/VBoxContainer/HBoxContainer/ResumeContainer.margin_left = 0
	$Container/VBoxContainer/HBoxContainer/ResumeContainer.margin_top = 0
	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_bottom = 0
	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_left = 90
	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_top = 0
	
	$Container/VBoxContainer/HBoxContainer/ResumeContainer/LblResume.margin_top = 47
	$Container/VBoxContainer/HBoxContainer/QuitContainer/LblQuit.margin_top = 47
	
	
	
func _process(_delta):
#	$Container/VBoxContainer/HBoxContainer/ResumeContainer.margin_left = 0
#	$Container/VBoxContainer/HBoxContainer/ResumeContainer.margin_top = 0
#	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_bottom = 0
#	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_left = 90
#	$Container/VBoxContainer/HBoxContainer/QuitContainer.margin_top = 0
	pass
#	$Container/VBoxContainer/HBoxContainer/ResumeContainer/LblResume.margin_top = 47
#	$Container/VBoxContainer/HBoxContainer/QuitContainer/LblQuit.margin_top = 47


func _on_BtnResume_pressed():
	if has_node("/root/FMOD/FMOD_start"):
		get_node("/root/FMOD/FMOD_start").unpause()
	get_tree().paused = false


func _on_BtnQuit_pressed():
	get_tree().quit()