extends Control
#This is the Title Screen Scene

var start=false #Tells me if the player pressed start
				#so that the title can fade and
				#opening animation can play

#Fades in Title
func _ready(): 
	$OpeningScene.play=false
	$AnimTitle.play("Fade")
	yield($AnimTitle,"animation_finished")
	if(!start):
		$PressStart/AnimPressStart.play("Blink")

#Waits for player input to fade out and start opening
func _process(_delta): 
	if(Input.is_action_pressed("ui_accept") && !start):
		start=true
		$OpeningScene.playOpening()
		$AnimTitle.play_backwards("Fade")
		$PressStart/AnimPressStart.play("Blink Faster",-1,10)
		yield($PressStart/AnimPressStart,"animation_finished")
