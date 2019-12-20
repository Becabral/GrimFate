extends CanvasLayer
onready var Level1 = preload("res://scenes/Level 1.tscn")
onready var Level2 = preload("res://scenes/Level 2.tscn")

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
	