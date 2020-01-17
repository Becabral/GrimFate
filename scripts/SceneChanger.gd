extends CanvasLayer
#This scene is in charge of changing scenes like
#levels with fades between them.
#Also preloads them so they don't take as much time.
var lamp = false
onready var Beginning = preload("res://scenes/Beginning.tscn")
#onready var Trial1 = preload("res://scenes/Trial1.tscn")
#onready var Trial2 = preload("res://scenes/Trial2.tscn")
#onready var Trial1E = preload("res://scenes/Trial1Entrance.tscn")
#onready var Trial2E = preload("res://scenes/Trial2Entrance.tscn")
#onready var River1 = preload("res://scenes/River1.tscn")
#onready var River2 = preload("res://scenes/River2.tscn")
#onready var GrimEnd = preload("res://scenes/GrimEnd.tscn")

signal scene_changed()

onready var animation_player = $AnimationPlayer
#onready var black = $Control/Black

func change_scene(path):
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path)==OK)
	animation_player.play_backwards("Fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	
func change_scene_slow(path):
	animation_player.play("Fade",-1,0.5)
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path)==OK)
	animation_player.play_backwards("Fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")