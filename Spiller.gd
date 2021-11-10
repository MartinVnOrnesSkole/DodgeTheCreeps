extends Area2D

export var maks_hastighet = 400  # Hvor fort spilleren beveger seg (pixels/sec).
var skjerm_storrelse  

func _ready():
	skjerm_storrelse = get_viewport_rect().size
	
func _process(delta):
	var bevegelse = Vector2() 
	if Input.is_action_pressed("ui_right"):
		bevegelse.x += 1
	if Input.is_action_pressed("ui_left"):
		bevegelse.x -= 1
	if Input.is_action_pressed("ui_down"):
		bevegelse.y += 1
	if Input.is_action_pressed("ui_up"):
		bevegelse.y -= 1
	if bevegelse.length() > 0:
		bevegelse = bevegelse.normalized() * maks_hastighet

	position += bevegelse * delta
	position.x = clamp(position.x, 0, skjerm_storrelse.x)
	position.y = clamp(position.y, 0, skjerm_storrelse.y)
	
