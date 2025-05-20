extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#Global.save_data()
	if player.just_hit: return
	player.state_label.text = "Idle"
	player.velocity.x = 0.0
	player.animation_player.play("Idle")
	player.just_dashed = false
	player.dash_label.text = "false"

func physics_update(delta: float) -> void:
	
	#if player.is_on_floor(): player.last_floor_position = player.position
	
	if Global.angel_player_bloqued:
		return
	
	#player.velocity.y += player.gravity * delta
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()

	

	if not player.is_on_floor():
		player.was_on_floor = true
		player.coyote_jump = true
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Up"):
		if !player.just_hit:
			player.last_angel_position[1] = player.last_angel_position[0]
			player.last_angel_position[0] = player.position
			finished.emit(JUMPING)
	elif (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and (!Input.is_action_pressed("Left") or !Input.is_action_pressed("Right")):
		finished.emit(RUNNING)

func _on_jump_buffer_wait_timer_timeout() -> void:
	if !player.just_hit:
		finished.emit(JUMPING)
	
