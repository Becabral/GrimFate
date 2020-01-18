extends Node2D

signal entered_fog

func _on_Area2D_body_entered(body):
	if body.get_name()=="Player":
		emit_signal("entered_fog")
		
