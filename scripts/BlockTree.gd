extends KinematicBody2D

func push(velocity:Vector2):
	move_and_slide(velocity,Vector2())
