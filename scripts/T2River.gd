extends StaticBody2D
onready var lilypad = preload("res://scenes/Lilypad.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal used_seed()

var direction= "up"
var can_spawn = true
var lily
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelPos/useLbl.hide()
	lily = lilypad.instance()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $LabelPos/useLbl.visible && Input.is_action_pressed("use") && player.seeds>0:
		lily.position=Vector2(self.position.x,player.position.y)
		get_parent().add_child(lily)
		emit_signal("used_seed")
		$LabelPos/useLbl.hide()
	pass


func _on_T2River_body_entered(body):
	pass # Replace with function body.


func _on_LeftMargin_body_entered(body):
	if body.get_name()=="Player":
		player=body
		if body.seeds>0:
			$LabelPos/useLbl.show()
	pass # Replace with function body.


func _on_RightMargin_body_entered(body):
	if body.get_name()=="Player":
		player=body
		if body.seeds>0:
			$LabelPos/useLbl.show()
	pass # Replace with function body.


func _on_LeftMargin_body_exited(body):
	if body.get_name()=="Player":
		$LabelPos/useLbl.hide()
	pass # Replace with function body.


func _on_RightMargin_body_exited(body):
	if body.get_name()=="Player":
		$LabelPos/useLbl.hide()
	pass # Replace with function body.
