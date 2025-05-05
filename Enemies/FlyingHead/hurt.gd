extends FlyingHeadState


func enter(previous_state_path: String, data := {}) -> void:
	flying_head.state_label.text = "hurt"
	#player.velocity.x = 0.0
	take_damage()
	flying_head.hurt_timer.start()

func physics_update(delta: float) -> void:
	flying_head.move_and_slide()
	flying_head.velocity *= 0.86

func take_damage() -> void:
	flying_head.animation_player.play("Hurt")
	SoundPlayer.play_sound(SoundPlayer.gun_hit)
	push_back()
	#flying_head.velocity *= 0.3
	flying_head.health -= 1
	if flying_head.health <= 0:
		flying_head.dead = true
		%Hitbox.set_deferred("disabled", true)
		Global.killed_enemies += 1
		flying_head.gui.update_enemies_label()
		SoundPlayer.play_sound(SoundPlayer.flying_head_death)
		%AnimationPlayer.play("Destroyed")
		flying_head.gen_orb()
		await  %AnimationPlayer.animation_finished
		flying_head.queue_free()

func push_back() -> void:
	flying_head.direction = flying_head.global_position.direction_to(flying_head.demon.global_position)
	flying_head.velocity = -flying_head.direction * 700.0 
	#flying_head.move_and_slide()

func _on_hurt_timer_timeout() -> void:
	if !flying_head.dead:
		finished.emit(MOVING)
