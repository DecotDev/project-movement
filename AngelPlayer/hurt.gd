extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	Global.angel_player_bloqued = true
	player.animation_player.pause()
	player.velocity = Vector2(0,0)
	print("Hurt state entered")
	player.move_and_slide()
	player.hurt_timer.start()
	player.just_hit = true
	player.jump_buffer_timer.stop()
	player.buffered_jump = false
	player.last_angel_position[0] = player.last_angel_position[1]
	flash()
#func physics_update(delta: float) -> void:

func flash() -> void:
	player.sprite.set_instance_shader_parameter("flash_opacity", 1.0)


func _on_hurt_timer_timeout() -> void:
	player.sprite.set_instance_shader_parameter("flash_opacity", 0.0)
	finished.emit(RESPAWNING)
