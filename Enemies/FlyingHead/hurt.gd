extends FlyingHeadState


func enter(previous_state_path: String, data := {}) -> void:
	flying_head.state_label.text = "hurt"
	#player.velocity.x = 0.0
	flying_head.animation_player.play("Hurt")
	flying_head.velocity *= 0.3
	flying_head.hurt_timer.start()

func physics_update(delta: float) -> void:
	flying_head.move_and_slide()

func take_damage() -> void:
	%AnimationPlayer.play("Hurt")
	flying_head.health -= 1
	if flying_head.health <= 0:
		flying_head.queue_free()


func _on_hurt_timer_timeout() -> void:
	finished.emit(MOVING)
