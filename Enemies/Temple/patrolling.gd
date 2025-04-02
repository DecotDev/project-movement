extends TempleState

var horizontal: bool = true
var down: bool = true
var up: bool = true
var left: bool = true
var right: bool = true
var last_h: bool = false

func enter(previous_state_path: String, data := {}) -> void:
	state_label.text = "Patrolling"
	%AnimationPlayer.play("Jiggle")

func physics_update(delta: float) -> void:
	demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	#temple.direction = temple.global_position.direction_to(temple.demon.global_position)
	%DirectionLabel.text = ("X: " + str(demon_direction.x) +  " Y: " + str(demon_direction.y))
	
	if horizontal:
		if demon_direction.x > 0:
			temple.direction.x = 1
			last_h = true
		elif demon_direction.x < 1:
			temple.direction.x = -1
	
	if !horizontal:
		if demon_direction.y > 0:
			temple.direction.y = 1
		elif demon_direction.y < 1:
			temple.direction.y = -1
		
	temple.velocity = temple.direction * temple.speed
	temple.move_and_slide()

func take_damage() -> void:
	pass
	#flying_head.animation_player.play("Hurt")
	#push_back()
	#flying_head.health -= 1
	#if flying_head.health <= 0:
		#Global.killed_enemies += 1
		#flying_head.gui.update_enemies_label()
		#flying_head.queue_free()
