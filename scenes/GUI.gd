extends Control
#

func _ready():
	pass
#	$MarginContainer/Items.visible = false
#
#
#
func _process(delta):
	$MarginContainer/Items/ItemLbl.rect_position.y = 0
	$MarginContainer/Items/Slot0.margin_left = 58
	$MarginContainer/Items/Slot1.margin_left = 152
#	$MarginContainer/Items/Slot1/Item1/count.text = str(count)
#	if Input.is_action_just_pressed("ui_down"):
#		$MarginContainer/Items.visible = true
#	if Input.is_action_just_pressed("ui_up"):
#		count += 1
	pass