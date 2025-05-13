extends PlayerState
@onready
var sprite: = %Sprite2D 

func enter(previous_state_path: String, data := {}) -> void:
	if player.just_hit: return
	#if player.velocity.x != 0.0:
		#player.animation_player.play("Run")
	player.state_label.text = "Running"
	player.animation_player.play("Run")
	player.just_dashed = false
	player.dash_label.text = "false"

func physics_update(delta: float) -> void:
	
	if Global.angel_player_bloqued:
		finished.emit(IDLE)
		return
	
	#if player.is_on_floor(): player.last_floor_position = player.position
	
	var input_direction_x := Input.get_axis("Left", "Right")
	player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * delta
	if input_direction_x < 0:
		sprite.flip_h = true
	if input_direction_x > 0:
		sprite.flip_h = false
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
	#elif is_equal_approx(input_direction_x, 0.0):
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)


func _on_jump_buffer_wait_timer_timeout() -> void:
	finished.emit(JUMPING)
