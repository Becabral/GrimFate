extends Area2D



func _on_EndFireSpawner_body_entered(body):
	if body.get_name()=="Player":
		get_parent().gray_count += 1 
		$Torch.lit=true
		$Torch2.lit=true
		if get_parent().gray_count == 1:
			get_parent().get_node("Player4").SPEED = 80
			get_parent().get_node("Player5").SPEED = 80
		elif get_parent().gray_count == 2:
			get_parent().get_node("Player6").SPEED = 50
			get_parent().get_node("Player7").SPEED = 50
