extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playercamera
var torchunlit = false
signal open
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_node("TorchC") and has_node("TorchD"):
		if $TorchC.lit and $TorchD.lit and has_node("Door"):
			$Door.queue_free()
			get_parent().get_node("Narrative_3").play_text()
			get_parent().get_node("Narrative_2").play_text_backwards()
			get_parent().get_node("Narrative_cloak").play_text_backwards()
	
	if has_node("BigTorch"):
		if !$BigTorch.lit and !torchunlit :
			torchunlit=true
			playercamera=get_parent().get_node("Player/Camera2D")
			playercamera.limit_top=-1800
			playercamera.limit_bottom=-740
			playercamera.limit_left=-1200
			yield(get_tree().create_timer(2), "timeout")
			playercamera.limit_top=-1000000
			playercamera.limit_bottom=1000000
			playercamera.limit_left=-1000000
		if $BigTorch.blue and $BigTorch.lit and has_node("Door"):
			emit_signal("open")
			$Door.queue_free()
#	pass