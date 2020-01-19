extends Control
var slot = 0
var slotSkill = 0
var countSeed = 0
var seedDisplay=-1
var player
var has_lamp = false

#cor dash - bf3760
#cor scythe - 4ff057

func _ready():
	$MarginContainer2/MainContainer/Items/ItemLbl.visible = false
	$MarginContainer2/MainContainer/Items/Slot0.visible = false
	$MarginContainer2/MainContainer/Items/Slot1.visible = false
	$MarginContainer/MainContainer/Skills/SkillLbl.visible = false
	$MarginContainer/MainContainer/Skills/Slot0.visible = false
	$MarginContainer/MainContainer/Skills/Slot1.visible = false
	player=get_parent().get_parent().get_node("Player")

func _process(_delta):
	$MarginContainer2/MainContainer/Items/ItemLbl.rect_position.y = 0
	$MarginContainer/MainContainer/Skills/SkillLbl.rect_position.y = 0
	
	$MarginContainer2/MainContainer/Items/Slot0.margin_left = 57
	$MarginContainer2/MainContainer/Items/Slot1.margin_left = 141

#------ caso tenha itens e skill junto na msm tela, rever essa regra abaixo
#	$MarginContainer/MainContainer/Skills.margin_top = 80

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
		#$MarginContainer2/MainContainer/Items/ItemLbl.visible = true
		$MarginContainer2/MainContainer/Items/Slot0/Item0/Icon.texture = load("res://assets/img/gui/New/"+item+".png")
		$MarginContainer2/MainContainer/Items/Slot0/MarginContainer/Lbl0.text = item
		$MarginContainer2/MainContainer/Items/Slot0.visible = true
		if item == "Lamp":
			$MarginContainer2/MainContainer/Items/Slot0/Item0/count.visible = false
		elif item == "Seed":
			seedDisplay=0
		slot += 1
	else:
		$MarginContainer2/MainContainer/Items/Slot1/Item1/Icon.texture = load("res://assets/img/gui/New/"+item+".png")
		$MarginContainer2/MainContainer/Items/Slot1/Lbl1.text = item
		$MarginContainer2/MainContainer/Items/Slot1.visible = true
		if item == "Lamp" and has_lamp == false:
			$MarginContainer2/MainContainer/Items/Slot1/Item1/count.visible = false
		elif item == "Seed":
			seedDisplay=1
			pass
			
func adiciona_skill(nome):
	if slotSkill == 0:
		#$MarginContainer/MainContainer/Skills/SkillLbl.visible = true
		if nome == "Dash":
			$MarginContainer/MainContainer/Skills/Slot0/Skill0.texture = load("res://assets/img/gui/GUI_Dash.png")
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set("custom_colors/font_color",Color(0.75,0.22,0.37,1))
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set_text("Tab")
		elif nome == "Scythe":
			$MarginContainer/MainContainer/Skills/Slot0/Skill0.texture = load("res://assets/img/gui/GUI_Scythe.png")
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set("custom_colors/font_color",Color(0.31,0.94,0.34,1))
			$MarginContainer/MainContainer/Skills/Slot0/Skill0/count.set_text("Space")
			
		$MarginContainer/MainContainer/Skills/Slot0/Skill0/Icon.texture = load("res://assets/img/gui/"+nome+".png")
		$MarginContainer/MainContainer/Skills/Slot0/Lbl0.text = nome
		$MarginContainer/MainContainer/Skills/Slot0.visible = true
		slotSkill +=1
	else:
		if nome == "Scythe":
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
		$MarginContainer2/MainContainer/Items/Slot0/Item0/count.set_text(str(countSeed))
	elif (seedDisplay==1):
		$MarginContainer2/MainContainer/Items/Slot1/Item1/count.set_text(str(countSeed))

func _on_T2River_used_seed():
	countSeed -= 1
	player.seeds-=1
	refreshSeeds()
	pass # Replace with function body.
