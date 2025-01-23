extends PlayerState
@onready
var Sprite = %Sprite2D

func enter(previous_state_path: String, data := {}) -> void:
	#if player.velocity.x != 0.0:
		#player.animation_player.play("Run")
	player.state_label.text = "Running"
	player.animation_player.play("Run")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("Left", "Right")
	player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * delta
	if input_direction_x < 0:
		Sprite.flip_h = true
	if input_direction_x > 0:
		Sprite.flip_h = false
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()

	if not player.is_on_floor():
		player.was_on_floor = true
		player.coyote_jump = true
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Up"):
		finished.emit(JUMPING)
	#elif is_equal_approx(input_direction_x, 0.0):
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)


func _on_jump_buffer_wait_timer_timeout() -> void:
	finished.emit(JUMPING)
