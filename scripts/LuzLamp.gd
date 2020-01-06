extends Light2D
var dado = 0

var hexaColor = "dfdc0b"
var alphaLuz = str(randi()%100+0)
var hexaColorAlpha = alphaLuz+hexaColor
func _ready():
	pass

func _process(_delta):
	pass

func _on_Timer_timeout():
	dado = randi()%11
	mudaLuz(dado)

func mudaLuz(num):
	if num > 4:
		hexaColor = "dfdc0b"
		alphaLuz = int(rand_range(20,99))
		if alphaLuz > 60:
			var escala = rand_range(0.1,0.18)
			set_scale(Vector2(escala, escala))
		else:
			var escala = rand_range(0.06,0.1)
			set_scale(Vector2(escala, escala))
		hexaColorAlpha = str(alphaLuz)+hexaColor
	set_color(hexaColorAlpha)
