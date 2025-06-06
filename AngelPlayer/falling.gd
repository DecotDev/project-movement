extends PlayerState
@onready
var sprite: Node = %Sprite2D


func enter(previous_state_path: String, data := {}) -> void:
	if player.just_hit: return
	player.state_label.text = "Falling"
	player.animation_player.play("Fall")
	if player.just_dashed and !player.just_respawned:
		player.dash_fall_impulse_timer.start()
	player.coyote_timer.start()

func physics_update(delta: float) -> void:
	if Global.angel_player_bloqued:
		player.velocity.y += round(player.gravity * delta)
		player.move_and_slide()
		if player.is_on_floor():
			finished.emit(IDLE)
		return

	var input_direction_x := Input.get_axis("Left", "Right")
	if player.just_respawned == true: input_direction_x = 0
	player.velocity.x = player.speed * input_direction_x 
	if player.just_dashed and !player.just_hit and !player.just_respawned:
		if player.dash_slow_fall <= 5:
			player.dash_slow_fall += 1
			player.velocity.y = round(player.velocity.y * 0.85)
		player.velocity.x += player.dash_impulse
		player.dash_impulse *= 0.94

	
	player.velocity.y += round(player.gravity * delta)
	
	if player.velocity.y > player.max_y_speed:
		player.velocity.y = player.max_y_speed
	
	if input_direction_x < 0:
		sprite.flip_h = true
	if input_direction_x > 0:
		sprite.flip_h = false
	if Input.is_action_pressed("Down") and !player.coyote_jump:
		if player.velocity.y < 800:
			player.velocity.y += player.fast_fall_vel - 120
		else:
			player.velocity.y += player.fast_fall_vel
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()
		
	if Input.is_action_just_pressed("Up"):
		player.jump_buffer_timer.start()
		player.buffered_jump = true
	
	if Input.is_action_just_pressed("Up") and player.was_on_floor and player.coyote_jump and !player.just_hit:
		finished.emit(JUMPING)
	
	if Input.is_action_just_pressed("Shift") and !player.just_dashed:
		finished.emit(DASHING)
	
	if player.is_on_floor():
		player.just_dashed = false
		if player.just_hit: return
		player.just_respawned = false
		if player.buffered_jump:
			player.jump_buffer_wait_timer.start()
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
		
func _on_jump_buffer_timer_timeout() -> void:
	player.buffered_jump = false
	
func _on_coyote_timer_timeout() -> void:
	player.coyote_jump = false


func _on_dash_fall_impulse_timeout() -> void:
	player.dash_label.text = "false"
	#player.just_dashed = false
