extends KinematicBody2D

const SPEED = 200

# state of the movement of the character "sideView" or "topView"
var STATE = "topView"

# set the initial sprite direction
var spritedir = "down"
var movedir = Vector2(0,0)

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spritedir_loop()
	
	#if the character is not standing still, than use the type of mov "walk". Else, use the type "idle"
	if movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var DOWN = Input.is_action_pressed("ui_down")
	var UP = Input.is_action_pressed("ui_up")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	
	#if the state is equal to "topView", it allows the character to move on both axis
	if (STATE == "topView"):
		movedir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"
			
#gets the type of animation, like: walk, idle, push)
func anim_switch(animation):
	#create a string that uses the type of the animation and concatenates with the direction, like: walk + left = walkleft
	#walkleft is the name of the animation of the character walking on the left direction
	var newanim = str(animation,spritedir)
	if $Anim.current_animation != newanim:
		$Anim.play(newanim)