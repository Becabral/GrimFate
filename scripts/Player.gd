extends KinematicBody2D

export var SPEED = 200
export var pushSPEED = 120
export var is_main_character = true
export var is_beggining = false
var is_moving_left = false
var is_moving_right=false
var is_moving_vertically=false
var can_dash = true
var is_flammable = true
var on_fire = false
var blue = false
onready var global = get_node("/root/SceneChanger")


#items
var lamp = false
var seeds = 0
var has_hood=false

var barco = false

# estado do movimento do personagem "topView" ou "sideView"
var STATE = "topView"

# set a direção para onde o personagem está olhando
var spritedir = "down"
var movedir = Vector2(0,0)

func _ready():

	
	if !is_beggining:
		$RotPos/AnimatedSprite/AnimatedSprite2.queue_free()
			
	if is_main_character == false:
		$Camera2D.queue_free()
		$RotPos/AnimatedSprite.play("Player_cinza_costas")
	else:
		if has_node("/root/FMOD/FMOD_start"):
			get_node("/root/FMOD/FMOD_start").set_listener(self)
			pass
	

func _physics_process(_delta):
	if barco != true:
		controls_loop()
		movement_loop()
		spritedir_loop()
	
	if lamp == false:
		$LuzLamp.visible = false
		$CollisionShape2D.disabled = false
		$ColisorLuz.disabled = true
	else:
		$ColisorLuz.disabled = false
		$CollisionShape2D.disabled = true
		if spritedir == "left":
			$LuzLamp.set_position(get_node("PosLampLeft").position)
		else:
			$LuzLamp.set_position(get_node("PosLampRight").position)
		$LuzLamp.visible = true
		
	
	if is_beggining == true:
		if lamp == true:
			$RotPos/AnimatedSprite.play("Player_lateral_lanterna")

	# se o personagem não esta parado, então usa o tipo de movimento "walk". Senão, usa o tipo "idle"
	if movedir != Vector2(0,0) and barco == false:
		#if lamp == false:
		if spritedir == "up":
			if is_main_character == true:
				if has_hood:
					if global.lamp == true:
						$RotPos/AnimatedSprite.play("Player_cloak_costas")
					else:
						$RotPos/AnimatedSprite.play("Player_cinza_cloak_costas")
				else:
					if global.lamp == true:
						$RotPos/AnimatedSprite.play("Player_costas")
					else:
						$RotPos/AnimatedSprite.play("Player_cinza_costas")
			else:
				$RotPos/AnimatedSprite.play("Player_cinza_costas")
		elif spritedir == "down":
			if is_main_character == true:
				if has_hood:
					if global.lamp == true:
						$RotPos/AnimatedSprite.play("Player_cloak_frente")
					else:
						$RotPos/AnimatedSprite.play("Player_cinza_cloak_frente")
				else:
					if global.lamp == true:
						$RotPos/AnimatedSprite.play("Player_frente")
					else:
						$RotPos/AnimatedSprite.play("Player_cinza_frente")
			else:
				$RotPos/AnimatedSprite.play("Player_cinza_frente")
		elif spritedir == "left" or spritedir == "right":
			
			if lamp == true:
				$RotPos/AnimatedSprite.play("Player_lateral_lanterna")
			else:
				if is_main_character == true:
					if has_hood:
						if global.lamp == true:
							$RotPos/AnimatedSprite.play("Player_cloak_lateral")
						else:
							$RotPos/AnimatedSprite.play("Player_cinza_cloak_lateral")
					else:
						if global.lamp == true:
							$RotPos/AnimatedSprite.play("Player_lateral")
						else:
							$RotPos/AnimatedSprite.play("Player_cinza_lateral")
				else:
					$RotPos/AnimatedSprite.play("Player_cinza_lateral")
					

		if spritedir == "left" && !is_moving_left:
			$Anim.play("moveleft")
			is_moving_left = true
			is_moving_right = false
			is_moving_vertically=false
		
		elif spritedir == "right" && !is_moving_right:
			$Anim.play("moveright")
			is_moving_left = false
			is_moving_right = true
			is_moving_vertically=false
		
		if (spritedir == "up" or spritedir == "down") and !is_moving_vertically:
			is_moving_vertically=true
			if is_moving_left:
				$Anim.play_backwards("moveleft")
				is_moving_left = false
			if is_moving_right:
				$Anim.play_backwards("moveright")
				is_moving_right = false
			
			
			
	else:
		if is_moving_left or is_moving_right:
			is_moving_left = false
			is_moving_right = false
			if spritedir == "left":
				$Anim.play_backwards("moveleft")
			else:
				$Anim.play_backwards("moveright")
		
	if on_fire:
		if blue:
			$FlameParticle/FireBlue.emitting = true
			$FlameParticle/FireRed.emitting = false
			#$FlameParticle.visible = true			
		else:
			$FlameParticle/FireRed.emitting = true
			$FlameParticle/FireBlue.emitting = false
			#$FlameParticle.visible = true			
	else:
		$FlameParticle/FireRed.emitting = false
		$FlameParticle/FireBlue.emitting = false

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var DOWN = Input.is_action_pressed("ui_down")
	var UP = Input.is_action_pressed("ui_up")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	
	# se o estado for igual a "topView", permite que o personagem mova em ambos os eixos
	if (STATE == "topView"):
		movedir.y = -int(UP) + int(DOWN)
		
	if (Input.is_action_pressed("ui_focus_next") && can_dash && has_hood):
		dash()
	
func movement_loop():
	var motion = movedir.normalized() * SPEED
	motion = move_and_slide(motion, Vector2(0,0))

	#box push
	if get_slide_count()>0:
		check_box_collision()
	
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
		
		
#Box push
func check_box_collision():
	if abs(movedir.x) + abs(movedir.y) > 1:
		return
	var box = get_slide_collision(0).collider
	if (box.has_method("push")):
		box.push(pushSPEED*movedir)

func dash():
	can_dash=false
	SPEED=800
	set_collision_mask_bit( 1, false)
	set_collision_layer_bit( 1, false)
	yield(get_tree().create_timer(0.2), "timeout")
	if on_fire:
		set_collision_mask_bit( 2, false)
		set_collision_layer_bit( 2, false)
		yield(get_tree().create_timer(0.2), "timeout")
		if blue:
			yield(get_tree().create_timer(0.3), "timeout")
	SPEED=200
	is_flammable=false
	on_fire=false
	blue=false
	yield(get_tree().create_timer(0.3), "timeout")
	set_collision_mask_bit( 1, true )
	set_collision_layer_bit( 1, true )
	set_collision_mask_bit( 2, true)
	set_collision_layer_bit( 2, true)
	can_dash=true
	is_flammable=true
	

func _on_GrimEnd_kill_players():
	queue_free()
	pass # Replace with function body.
