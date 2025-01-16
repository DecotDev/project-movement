extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state_label.text = "Idle"
	player.velocity.x = 0.0
	player.animation_player.play("Idle")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		player.was_on_floor = true
		player.coyote_jump = true
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Up"):
		finished.emit(JUMPING)
	elif (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and (!Input.is_action_pressed("Left") or !Input.is_action_pressed("Right")):
		finished.emit(RUNNING)

func _on_jump_buffer_wait_timer_timeout() -> void:
	finished.emit(JUMPING)
