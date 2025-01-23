extends PlayerState
@onready
var Sprite = %Sprite2D
var input_direction_x

func enter(previous_state_path: String, data := {}) -> void:
	input_direction_x = Input.get_axis("Left", "Right")
	player.dash_impulse *= input_direction_x
	player.state_label.text = "Dashing"
	player.animation_player.play("Dash")
	player.dash_finish_timer.start()

func physics_update(delta: float) -> void:
	player.velocity.x = (600 * input_direction_x) * 2.6
	player.velocity.y = 0
	player.vel_y_label.text = "Vel: " + str(player.velocity.y)
	player.vel_x_label.text = "Speed: " + str(player.velocity.x)
	player.move_and_slide()

func _on_dash_finish_timer_timeout() -> void:
	player.just_dashed = true
	player.dash_label.text = "true"
	finished.emit(FALLING)
