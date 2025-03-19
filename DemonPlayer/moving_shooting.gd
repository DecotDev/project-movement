extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	state_label.text = "MovShoot"
	%AnimationPlayer.play("Run")


func physics_update(delta: float) -> void:
	demon.camera.mouse_pos = demon.get_global_mouse_position()
	demon.input_direction = Input.get_vector("Left","Right","Up","Down")
	#input_direction = input_direction.normalized()
	demon.velocity = demon.input_direction * 450
	demon.move_and_slide()
	
	if demon.camera.mouse_pos.x < demon.position.x:
		sprite.flip_h = true
		if !demon.gun_moved_left:

			demon.gun.position.x = -28
			demon.gun_moved_left = true
			demon.gun_moved_right = false
			demon.gun.sprite.flip_v = true
	else:
		sprite.flip_h = false
		if !demon.gun_moved_right:
			demon.gun.position.x = + 28
			demon.gun_moved_left = false
			demon.gun_moved_right = true
			demon.gun.sprite.flip_v = false

	if Input.is_action_just_pressed("Space") and demon.roll_available:
		demon.roll_available = false
		demon.roll_cooldown_timer.start()
		finished.emit(ROLL)
	elif is_equal_approx(demon.input_direction.x, 0.0) and is_equal_approx(demon.input_direction.y, 0.0):
		finished.emit(IDLE)




func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
	#if body.has_method("damage_demon"):
		#Global.demon_health -= 1
		#demon.gui.update_health_label()
