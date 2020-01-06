extends Area2D

var player
var block=preload("res://scenes/BlockTree.tscn")

signal used_seed

func _ready():
	player=get_parent().get_node("Player")
	$LabelPos/useLbl.hide()

func _process(_delta):
	if $LabelPos/useLbl.visible && Input.is_action_pressed("use") && player.seeds>0:
		var bloco = block.instance()
		get_parent().add_child(bloco)
		bloco.position=self.position
		emit_signal("used_seed")

func _on_BlockBed_body_entered(body):
	if body.get_name()=="Player":
		$LabelPos/useLbl.show()

func _on_BlockBed_body_exited(body):
	if body.get_name()=="Player":
		$LabelPos/useLbl.hide()
