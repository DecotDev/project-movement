extends TempleState

var horizontal: bool = true
var down: bool = true
var up: bool = true
var left: bool = true
var right: bool = true
var last_h: bool = false

func enter(previous_state_path: String, data := {}) -> void:
	temple.shooting = false
	#print("e- Patrol Y")
	#print("shooting: " + str(temple.shooting))
	temple.can_lock_player = true
	%AnimationPlayer.play("Jiggle")
	temple.direction = Vector2(0,0)
	%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 1
	state_label.text = "Patrol Y"
	up = false
	down = false

func physics_update(delta: float) -> void:
	demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	#temple.direction = temple.global_position.direction_to(temple.demon.global_position)
	%DirectionLabel.text = ("X: " + str(demon_direction.x) +  " Y: " + str(demon_direction.y))
	
	if demon_direction.y > 0:
		temple.direction.y = 1
		up = true
	elif demon_direction.y < 1:
		temple.direction.y = -1
		down = true

	if up and down:
		temple.direction = Vector2(0,0)
		finished.emit(PATROL_X)
		
	temple.velocity = temple.direction * temple.speed
	temple.move_and_slide()

	#flying_head.animation_player.play("Hurt")
	#push_back()
	#flying_head.health -= 1
	#if flying_head.health <= 0:
		#Global.killed_enemies += 1
		#flying_head.gui.update_enemies_label()
		#flying_head.queue_free()
