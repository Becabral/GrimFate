extends KinematicBody2D

const SPEED = 200
var cameraY = -300

#items
var lamp = false

# estado do movimento do personagem "topView" ou "sideView"
var STATE = "topView"

# set a direção para onde o personagem está olhando
var spritedir = "down"
var movedir = Vector2(0,0)

func _physics_process(_delta):
	controls_loop()
	movement_loop()
	spritedir_loop()

	# se o personagem não esta parado, então usa o tipo de movimento "walk". Senão, usa o tipo "idle"
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
	
	# se o estado for igual a "topView", permite que o personagem mova em ambos os eixos
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
			
# pega o tipo de animação, como: walk, idle, push
func anim_switch(animation):
	# cria uma string que usa o "tipo" da animação e concatena com a direção, exemplo: walk + left = walkleft
	# walkleft é o nome da animação do personagem andando para a direção "left"
	var newanim = str(animation,spritedir)
	if $Anim.current_animation != newanim:
		$Anim.play(newanim)