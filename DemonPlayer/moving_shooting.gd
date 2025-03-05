extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	state_label.text = "MovShoot"
	%AnimationPlayer.play("Idle")


func physics_update(delta: float) -> void:
	demon.camera.mouse_pos = demon.get_global_mouse_position()
	demon.input_direction = Input.get_vector("Left","Right","Up","Down")
	#input_direction = input_direction.normalized()
	demon.velocity = demon.input_direction * 550
	demon.move_and_slide()
	
	if demon.camera.mouse_pos.x < demon.position.x:
		demon.sprite.flip_h = false
		sprite_s_d.flip_h = true
		if !demon.gun_moved_left:

			demon.gun.position.x = -25
			demon.gun_moved_left = true
			demon.gun_moved_right = false
			demon.gun.sprite.flip_v = true
	else:
		demon.sprite.flip_h = true
		sprite_s_d.flip_h = false
		if !demon.gun_moved_right:
			demon.gun.position.x = + 25
			demon.gun_moved_left = false
			demon.gun_moved_right = true
			demon.gun.sprite.flip_v = false
	if Input.is_action_just_pressed("Space"):
		finished.emit(ROLL)





func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
	#if body.has_method("damage_demon"):
		#Global.demon_health -= 1
		#demon.gui.update_health_label()
