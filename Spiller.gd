extends Area2D
signal hit

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
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if (bevegelse.x != 0):
		$AnimatedSprite.animation = "hoyre"
		$AnimatedSprite.flip_v = false
		if (bevegelse.x > 0):
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	elif (bevegelse.y != 0):
		$AnimatedSprite.animation = "opp" 
		if (bevegelse.y > 0):
			$AnimatedSprite.flip_v = true
		else:
			$AnimatedSprite.flip_v = false

	position += bevegelse * delta
	position.x = clamp(position.x, 0, skjerm_storrelse.x)
	position.y = clamp(position.y, 0, skjerm_storrelse.y)
	


func _on_Spiller_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
