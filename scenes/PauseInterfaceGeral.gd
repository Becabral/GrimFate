extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if $PauseButton.isPaused == false:
		$PausedGUI/Container.hide()
		$PausedGUI/Fundo.hide()
	else:
		$PausedGUI/Container.show()
		$PausedGUI/Fundo.show()
		get_tree().paused = true
		$PauseButton.isPaused = false