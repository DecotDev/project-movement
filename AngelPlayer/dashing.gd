extends PlayerState
@onready
var Sprite: Node = %Sprite2D
var input_direction_x: int

func enter(previous_state_path: String, data := {}) -> void:
	player.dash_impulse = player.dash_impulse_reset
	player.velocity.y = round(player.velocity.y * 0.2)
	input_direction_x = Input.get_axis("Left", "Right")
	player.dash_impulse *= input_direction_x
	player.state_label.text = "Dashing"
	player.animation_player.play("Dash")
	player.dash_slow_fall = 0
	player.dash_finish_timer.start()

func physics_update(delta: float) -> void:
	print( str(input_direction_x))
	player.velocity.x = (600 * input_direction_x) * 2
	#if player.velocity.y < 0:
		#player.velocity.y *= 0.9
	#else:
		#player.velocity.y *= 0.84
	if player.velocity.y > 0 and input_direction_x != 0:
		player.velocity.y = round(player.velocity.y * 0.5) #4
	else:
		player.velocity.y = round(player.velocity.y * 0.9)
	if player.velocity.y < 0:
		print(str(player.velocity.y))
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()

func _on_dash_finish_timer_timeout() -> void:
	player.just_dashed = true
	player.dash_label.text = "true"
	finished.emit(FALLING)
