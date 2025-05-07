extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	Global.angel_player_bloqued = false
	player.just_hit = false
	player.just_respawned = true
	player.animation_player.play("Respawn")
	player.position = player.last_floor_position + Vector2(0,-64)
	player.respawn_timer.start()

#func physics_update(delta: float) -> void:

func _on_respawn_timer_timeout() -> void:
	player.sprite.set_instance_shader_parameter("flash_opacity", 0.0)
	finished.emit(FALLING)
