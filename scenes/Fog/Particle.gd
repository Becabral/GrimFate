extends RigidBody2D

var lamp = false
var visivel = true

func _ready():
	pass

func _process(_delta):
	if lamp == true:
		$Colisor.disabled = true
		teste_tocando()
	
func _on_Area2D_body_entered(body):
	if body.get_name()=="Player" and lamp == true:
		visivel = false
		queue_free()

func teste_tocando():
	if visivel == true:
		$AnimatedSprite.show()
	else:
		$AnimatedSprite.hide()
		visivel = true