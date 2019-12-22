extends Control
var slot = 0
var countSeed = 0

func _ready():
	$MarginContainer/Items/ItemLbl.visible = false
	$MarginContainer/Items/Slot0.visible = false
	$MarginContainer/Items/Slot1.visible = false
#
#
#
func _process(delta):
	$MarginContainer/Items/ItemLbl.rect_position.y = 0
	$MarginContainer/Items/Slot0.margin_left = 58
	$MarginContainer/Items/Slot1.margin_left = 152


func verifica_incrementa(item):
	print("entrou"+item)
	if item == "Lamp":
		adiciona_interface("Lamp")
	elif item == "Seed":
		if countSeed == 0:
			adiciona_interface("Seed")
			countSeed += 1
		else:
			countSeed += 1
	
func adiciona_interface(item):
	print("entrou2")
	if slot == 0:
		$MarginContainer/Items/ItemLbl.visible = true
		$MarginContainer/Items/Slot0/Item0/Icon.texture = load("res://assets/img/gui/"+item+".png")
		$MarginContainer/Items/Slot0/Lbl0.text = item
		$MarginContainer/Items/Slot0.visible = true
		if item == "Lamp":
			$MarginContainer/Items/Slot0/Item0/count.visible = false
		elif item == "Seed":
			$MarginContainer/Items/Slot0/Item0/count.text = str(countSeed)
		slot += 1
	else:
		$MarginContainer/Items/Slot1/Item1/Icon.texture = load("res://assets/img/gui/"+item+".png")
		$MarginContainer/Items/Slot1/Lbl1.text = item
		$MarginContainer/Items/Slot1.visible = true
		if item == "Lamp":
			$MarginContainer/Items/Slot1/Item1/count.visible = false
		elif item == "Seed":
			$MarginContainer/Items/Slot1/Item1/count.text = str(countSeed)