extends Node

export (PackedScene) var Fiende
var poeng

func _ready():
	randomize()


func game_over():
	$PoengTimer.stop()
	$FiendeTimer.stop()
	$HUD.vis_game_over()


func new_game():
	poeng = 0
	$Spiller.start($StartPosisjon.position)
	$StartTimer.start()
	$HUD.oppdater_poeng(poeng)
	$HUD.vis_beskjed("Get Ready")


func _on_FiendeTimer_timeout():
	# Spawn fiende
	var fiende = Fiende.instance()
	# Legg fienden til scenen.
	add_child(fiende)
	
	# Velg tilfeldig punkt langs stien og sett fiendens posisjon basert på dette.
	$FiendePath/FiendeSpawnPoint.offset = randi()
	fiende.position = $FiendePath/FiendeSpawnPoint.position
	
	# Roter fienden så den peker rett ut av punktet på stien
	var retning = $FiendePath/FiendeSpawnPoint.rotation + deg2rad(90)
	# Gjør retningen litt tilfeldig 
	retning += deg2rad(rand_range(-45, 45))
	fiende.rotation = retning

	# Set the velocity (speed & direction).
	fiende.linear_velocity = Vector2(rand_range(fiende.min_speed, fiende.max_speed), 0)
	fiende.linear_velocity = fiende.linear_velocity.rotated(retning)


func _on_PoengTimer_timeout():
	poeng += 1
	$HUD.oppdater_poeng(poeng)


func _on_StartTimer_timeout():
	$FiendeTimer.start()
	$PoengTimer.start()
