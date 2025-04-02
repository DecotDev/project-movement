extends TempleState

func enter(previous_state_path: String, data := {}) -> void:
	temple.shooting = true
	print("e- Shooting")
	print("shooting: " + str(temple.shooting))
	state_label.text = "Shooting"
	%AnimationPlayer.play("Ignite")
	#print("Start shoot state")
	shoot()

func shoot() -> void:
	await %AnimationPlayer.animation_finished
	const PROJECTILE = preload("res://Enemies/Projectiles/projectile.tscn")
	var new_projectile: = PROJECTILE.instantiate()
	#shot_sound()
	new_projectile.global_position = %ShootPoint.global_position
	#new_projectile.global_rotation = %ShootPoint.rotation
	#new_projectile.global_rotation += rng.randf_range(-0.02, 0.02)
	%ShootPoint.add_child(new_projectile)
	#print("Projectile shoot")
	
	%AnimationPlayer.play("Reload")
	await %AnimationPlayer.animation_finished
	finished.emit(SHOOTING)

	
#func physics_update(delta: float) -> void:
	#demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	##temple.direction = temple.global_position.direction_to(temple.demon.global_position)
	##%DirectionLabel.text = ("X: " + str(demon_direction.x) +  " Y: " + str(demon_direction.y))
	#%VelocityLabel.text = ("X: " + str(temple.velocity.x) +  " Y: " + str(temple.velocity.y))
	#velocity_x = temple.velocity.x
	#velocity_y = temple.velocity.y
	#if velocity_x == 10 or velocity_y == 10 or velocity_x == -10 or velocity_y == -10:
		#await %AnimationPlayer.animation_finished
		#finished.emit(SHOOTING)
	#
