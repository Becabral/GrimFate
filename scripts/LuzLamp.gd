extends Light2D

func _ready():
	pass

func _process(_delta):
	$Anim.play("flicker")
