extends Control
var slot = 0
var slotSkill = 0
var countSeed = 0
var seedDisplay=-1
var player

#cor dash - bf3760
#cor scythe - 4ff057

func _ready():
	$MarginContainer/MainContainer/Items/ItemLbl.visible = false
	$MarginContainer/MainContainer/Items/Slot0.visible = false
	$MarginContainer/MainContainer/Items/Slot1.visible = false
	$MarginContainer/MainContainer/Skills/SkillLbl.visible = false
	$MarginContainer/MainContainer/Skills/Slot0.visible = false
	$MarginContainer/MainContainer/Skills/Slot1.visible = false
	player=get_parent().get_parent().get_node("Player")

func _process(_delta):
	$MarginContainer/MainContainer/Items/ItemLbl.rect_position.y = 0
	$MarginContainer/MainContainer/Skills/SkillLbl.rect_position.y = 0
	
	$MarginContainer/MainContainer/Items/Slot0.margin_left = 57
	$MarginContainer/MainContainer/Items/Slot1.margin_left = 141
	$MarginContainer/MainContainer/Skills.margin_top = 80

func verifica_incrementa(item):
	if item == "Lamp":
		adiciona_interface("Lamp")
	elif item == "Seed":
		countSeed += 1
		if seedDisplay==-1:
			adiciona_interface("Seed")
		refreshSeeds()
		
func adiciona_interface(item):
	if slot == 0:
		$MarginContainer/MainContainer/Items/ItemLbl.visible = true
		$MarginContainer/MainContainer/Items/Slot0/Item0/Icon.texture = load("res://assets/img/gui/"+item+".png")
		$MarginContainer/MainContainer/Items/Slot0/Lbl0.text = item
		$MarginContainer/MainContainer/Items/Slot0.visible = true
		if item == "Lamp":
			$MarginContainer/MainContainer/Items/Slot0/Item0/count.visible = false
		elif item == "Seed":
			seedDisplay=0
		slot += 1
	else:
		$MarginContainer/MainContainer/Items/Slot1/Item1/Icon.texture = load("res://assets/img/gui/"+item+".png")
		$MarginContainer/MainContainer/Items/Slot1/Lbl1.text = item
		$MarginContainer/MainContainer/Items/Slot1.visible = true
		if item == "Lamp":
			$MarginContainer/MainContainer/Items/Slot1/Item1/count.visible = false
		elif item == "Seed":
			seedDisplay=1
			pass
			
func adiciona_skill(nome):
	if slotSkill == 0:
		$MarginContainer/MainContainer/Skills/SkillLbl.visible = true
		if nome == "Dash":
			$MarginContainer/MainContainer/Skills/Slot0/Skill0.texture = load("res://assets/img/gui/GUI_Dash.png")
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set("custom_colors/font_color",Color(0.75,0.22,0.37,1))
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set_text("Tab")
		else:
			$MarginContainer/MainContainer/Skills/Slot0/Skill0.texture = load("res://assets/img/gui/GUI_Scythe.png")
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set("custom_colors/font_color",Color(0.31,0.94,0.34,1))
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set_text("Space")
			
		$MarginContainer/MainContainer/Skills/Slot0/Skill0/Icon.texture = load("res://assets/img/gui/"+nome+".png")
		$MarginContainer/MainContainer/Skills/Slot0/Lbl0.text = nome
		$MarginContainer/MainContainer/Skills/Slot0.visible = true
		slotSkill +=1
	else:
		$MarginContainer/MainContainer/Skills/Slot1/Skill1.texture = load("res://assets/img/gui/GUI_Scythe.png")
		$MarginContainer/MainContainer/Skills/Slot1/Skill1/Icon.texture = load("res://assets/img/gui/"+nome+".png")
		$MarginContainer/MainContainer/Skills/Slot1/Lbl1.text = nome
		$MarginContainer/MainContainer/Skills/Slot1.visible = true
		

	
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
		$MarginContainer/MainContainer/Items/Slot0/Item0/count.set_text(str(countSeed))
	elif (seedDisplay==1):
		$MarginContainer/MainContainer/Items/Slot1/Item1/count.set_text(str(countSeed))