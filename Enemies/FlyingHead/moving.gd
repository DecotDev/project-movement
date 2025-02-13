extends FlyingHeadState


func enter(previous_state_path: String, data := {}) -> void:
	flying_head.state_label.text = "Moving"
	#player.velocity.x = 0.0
	flying_head.animation_player.play("Idle")

func physics_update(delta: float) -> void:
	if flying_head.dir_countdown <= 0:
		flying_head.direction = flying_head.global_position.direction_to(flying_head.demon.global_position)
		changeDirection()
		flying_head.dir_countdown = flying_head.rng.randf_range(20,60)
	flying_head.dir_countdown -= 1
	flying_head.velocity = flying_head.direction * 180.0 
	flying_head.move_and_slide()

func changeDirection() -> void:
	flying_head.direction.x += flying_head.rng.randf_range(-0.6,0.6)
	flying_head.direction.y += flying_head.rng.randf_range(-0.6,0.6)
