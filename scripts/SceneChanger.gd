extends CanvasLayer
#This scene is in charge of changing scenes like
#levels with fades between them.
#Also preloads them so they don't take as much time.

onready var Trial1 = preload("res://scenes/Trial1.tscn")
onready var Trial2 = preload("res://scenes/Trial2.tscn")

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Black

func change_scene(path):
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path)==OK)
	animation_player.play_backwards("Fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	