extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Moving state entered")
	#if Global.player_health < 1:
		#print("On moving enter death")
		#return
	state_label.text = "MovShoot"

	%AnimationPlayer.play("Run")
	


func physics_update(delta: float) -> void:
	#if Global.player_health < 1:
		#print("On moving death")
		#return
	if Global.demon_player_bloqued == true: # and Global.demon_health > 0:
		finished.emit(IDLE)
	demon.camera.mouse_pos = demon.get_global_mouse_position()
	demon.input_direction = Input.get_vector("Left","Right","Up","Down")
	#input_direction = input_direction.normalized()
	demon.velocity = demon.input_direction * demon.speed
	demon.move_and_slide()
	demon.update_skills_coowldown()
	
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

	if Input.is_action_just_pressed("Space") and demon.dash_available:
		finished.emit(DASH)
	elif is_equal_approx(demon.input_direction.x, 0.0) and is_equal_approx(demon.input_direction.y, 0.0): #and Global.demon_health > 0:
		finished.emit(IDLE)
