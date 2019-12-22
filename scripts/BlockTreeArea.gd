extends Area2D

var playerbody


func _ready():
	$CollisionShape2D.disabled=true
	$LabelPos/useLbl.hide()
	yield(get_tree().create_timer(1.0), "timeout")
	$CollisionShape2D.disabled=false
	pass 

func _on_BlockTreeArea_body_entered(body):
	if body.get_name()=="Player":
		playerbody=body
		$LabelPos/useLbl.show()


func _on_BlockTreeArea_body_exited(body):
	if body.get_name()=="Player":
		$LabelPos/useLbl.hide()

func _process(_delta):
	if $LabelPos/useLbl.visible && Input.is_action_pressed("use") :
		playerbody.seeds +=1
		get_parent().add()
		get_parent().queue_free()
