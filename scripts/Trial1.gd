extends Node2D
#onready var Level2 = preload("res://scenes/Level 2.tscn")

func _ready():
	pass 

func _on_NextArea_body_entered(body):
	if body.get_name()=="Player":
		if has_node("/root/SceneChanger"):
			get_node("/root/SceneChanger").change_scene("res://scenes/Trial2.tscn")
	pass # Replace with function body.
