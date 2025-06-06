extends PlayerState
@onready
var sprite: = %Sprite2D


func enter(previous_state_path: String, data := {}) -> void:
	#Global.save_data()
	if player.just_hit:
		print("Jump with hit")
		return
	#if player.buffered_jump:
	#	player.velocity.y = -player.jump_impulse
	#else:
	player.state_label.text = "Jumping"
	player.was_on_floor = false
	player.just_dashed = false
	player.dash_label.text = "false"
	player.velocity.y = -player.jump_impulse
	player.jump_high_timer.start()
	player.animation_player.play("Jump")

func physics_update(delta: float) -> void:
	if Global.angel_player_bloqued:
		player.velocity.x = 0
		player.velocity.y += round(player.gravity * delta)
		player.move_and_slide()
		if player.velocity.y >= 0:
			finished.emit(FALLING)
		return
	var input_direction_x := Input.get_axis("Left", "Right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += round(player.gravity * delta)
	if input_direction_x < 0:
		sprite.flip_h = true
	if input_direction_x > 0:
		sprite.flip_h = false

	#if Input.is_action_pressed("Down") and !player.coyote_jump:
		#if player.velocity.y < 800:
			#player.velocity.y += player.fast_fall_vel - 120
		#else:
			#player.velocity.y += player.fast_fall_vel
	if Input.is_action_pressed("Down"):
		player.velocity.y += player.fast_fall_vel - 80
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		finished.emit(FALLING)
		
	if Input.is_action_just_pressed("Shift"):
		finished.emit(DASHING)

func _on_jump_high_timer_timeout() -> void:
	if !Input.is_action_pressed("Up"):
		if player.velocity.y < -650:
			player.velocity.y = -650
	#else:
		#print("High jump")
