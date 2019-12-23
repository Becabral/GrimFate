extends Control
var slot = 0
var countSeed = 0
var seedDisplay=-1
var player

func _ready():
	$MarginContainer/Items/ItemLbl.visible = false
	$MarginContainer/Items/Slot0.visible = false
	$MarginContainer/Items/Slot1.visible = false
	player=get_parent().get_parent().get_node("Player")

func _process(delta):
	$MarginContainer/Items/ItemLbl.rect_position.y = 0
	$MarginContainer/Items/Slot0.margin_left = 58
	$MarginContainer/Items/Slot1.margin_left = 152

func verifica_incrementa(item):
	print("entrou"+item)
	if item == "Lamp":
		adiciona_interface("Lamp")
	elif item == "Seed":
		countSeed += 1
		if seedDisplay==-1:
			adiciona_interface("Seed")
		refreshSeeds()
		
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
			seedDisplay=0
		slot += 1
	else:
		$MarginContainer/Items/Slot1/Item1/Icon.texture = load("res://assets/img/gui/"+item+".png")
		$MarginContainer/Items/Slot1/Lbl1.text = item
		$MarginContainer/Items/Slot1.visible = true
		if item == "Lamp":
			$MarginContainer/Items/Slot1/Item1/count.visible = false
		elif item == "Seed":
			seedDisplay=1
			pass

	
func addSeed():
	verifica_incrementa("Seed")
	player.seeds+=1
	pass

func _on_BlockBed_used_seed():
	countSeed -= 1
	player.seeds-=1
	refreshSeeds()
	pass # Replace with function body.

func refreshSeeds():
	if(seedDisplay==0):
		$MarginContainer/Items/Slot0/Item0/count.set_text(str(countSeed))
	elif (seedDisplay==1):
		$MarginContainer/Items/Slot1/Item1/count.set_text(str(countSeed))