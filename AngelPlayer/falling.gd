extends PlayerState
@onready
var Sprite = %Sprite2D



func enter(previous_state_path: String, data := {}) -> void:
	player.state_label.text = "Falling"
	player.animation_player.play("Fall")
	player.coyote_timer.start()

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("Left", "Right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	
	if player.velocity.y > player.max_y_speed:
		player.velocity.y = player.max_y_speed
	
	if input_direction_x < 0:
		Sprite.flip_h = true
	if input_direction_x > 0:
		Sprite.flip_h = false
	if Input.is_action_pressed("Down") and !player.coyote_jump:
		if player.velocity.y < 800:
			player.velocity.y += player.fast_fall_vel - 120
		else:
			player.velocity.y += player.fast_fall_vel
	player.Vel_Y_label.text = "Vel: " + str(player.velocity.y)
	player.move_and_slide()
		
	if Input.is_action_just_pressed("Up"):
		player.jump_buffer_timer.start()
		player.buffered_jump = true
	
	if Input.is_action_just_pressed("Up") and player.was_on_floor and player.coyote_jump:
		finished.emit(JUMPING)
		
	if player.is_on_floor():
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
