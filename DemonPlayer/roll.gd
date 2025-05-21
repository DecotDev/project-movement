extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if Global.player_health < 1: return
	demon.dash_available = false
	demon.dash_cooldown_timer.start()
	demon.velocity *= 1.9
	state_label.text = "Dash"
	demon.dash_timer.start()
	demon.invencible = true

func physics_update(delta: float) -> void:
	demon.move_and_slide()
	demon.update_skills_coowldown()

func _on_dash_timer_timeout() -> void:
	demon.invencible = false
	finished.emit(MOVING_SHOOTING)
