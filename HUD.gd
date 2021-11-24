extends CanvasLayer

signal start_game

func vis_beskjed(beskjed):
	$Beskjed.text = beskjed
	$Beskjed.show()
	$BeskjedTimer.start()
	
func vis_game_over():
	vis_beskjed("Game Over")
	yield($BeskjedTimer, "timeout")
	$Beskjed.text = "Dodge the Creeps!"
	$Beskjed.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartKnapp.show()

func oppdater_poeng(poeng):
	$PoengTekst.text = str(poeng)


func _on_StartKnapp_pressed():
	$StartKnapp.hide()
	emit_signal("start_game")


func _on_BeskjedTimer_timeout():
	$Beskjed.hide()
