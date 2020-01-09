extends Area2D
var touch = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	$useLbl.hide()
	get_parent().get_node("FireEvent").hide()
	get_parent().get_node("FireEvent/StaticBody2D/CollisionShape2D").disabled=true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("use") && touch):
			player.has_hood = true
			get_parent().get_node("Interface/GUI").adiciona_skill("Dash")
			get_parent().get_node("FireEvent").show()
			get_parent().get_node("FireEvent/StaticBody2D/CollisionShape2D").disabled=false
			queue_free()
#	pass


func _on_Hood_body_entered(body):
	if body.get_name()=="Player":
		$useLbl.show()
		touch=true
		player=body
		
	



func _on_Hood_body_exited(body):
	if body.get_name()=="Player":
		touch=false
		$useLbl.hide()
