extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	demon.roll_timer.start()
	demon.invencible = true

func physics_update(delta: float) -> void:
	demon.move_and_slide()

func _on_roll_timer_timeout() -> void:
	demon.invencible = false
	finished.emit(MOVING_SHOOTING)
