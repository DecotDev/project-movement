extends TempleState

var velocity_x: int
var velocity_y: int

func enter(previous_state_path: String, data := {}) -> void:
	#temple.can_lock_player = false
	#print("e- Charging")
	#print("shooting: " + str(temple.shooting))
	state_label.text = "Charging"
	#%AnimationPlayer.play("Charge")
	%ChargeTimer.start()

	#if %AnimationPlayer.current_animation == "Jiggle":
		#%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 0
		#await %AnimationPlayer.animation_finished
	#%AnimationPlayer.play("Charge")
	#%ChargeTimer.start()
	
func physics_update(delta: float) -> void:
	demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	#%VelocityLabel.text = ("X: " + str(temple.velocity.x) +  " Y: " + str(temple.velocity.y))
	velocity_x = temple.velocity.x
	velocity_y = temple.velocity.y
	#%VelocityLabel.text = ("X: " + str(velocity_x) +  " Y: " + str(velocity_y))
	#if velocity_x == 10 or velocity_y == 10 or velocity_x == -10 or velocity_y == -10:
	temple.velocity.x = lerp(temple.velocity.x, 0.0 , 0.02)
	temple.velocity.y = lerp(temple.velocity.y, 0.0 , 0.02)
	temple.move_and_slide()
	%VelocityLabel.text = ("X: " + str(temple.velocity.x) +  " Y: " + str(temple.velocity.y))
	#if %AnimationPlayer.current_animation == "Charging":
		#await %AnimationPlayer.animation_finished
		#if !temple.shooting and !%AnimationPlayer.is_playing():
			#temple.shooting = true
			#finished.emit(SHOOTING)
	
	
	#if velocity_x == 10 or velocity_y == 10 or velocity_x == -10 or velocity_y == -10:
	
	#if (velocity_x < 10 and velocity_x > -10) and (velocity_y < 10 and velocity_y > -10):
	#if (velocity_x < 12 and velocity_x > 0) or (velocity_x > -12 and velocity_y < 0) and (velocity_y < 12 and velocity_y > 0) or (velocity_y > -12 and velocity_y < 0):
		#if !temple.shooting:
			#temple.shooting = true
			#%ChargeTimer.stop()
			#await %AnimationPlayer.animation_finished
			#finished.emit(SHOOTING)
			
	#if velocity_x == 10 or velocity_y == 10 or velocity_x == -10 or velocity_y == -10:
	#if (velocity_x < 12 and velocity_x > 0) or (velocity_x > -12 and velocity_y < 0) and (velocity_y < 12 and velocity_y > 0) or (velocity_y > -12 and velocity_y < 0):
		#if %AnimationPlayer.is_playing():
			#await %AnimationPlayer.animation_finished
		#if !temple.shooting:
			#finished.emit(SHOOTING)
	#else:
		#temple.velocity.x = lerp(temple.velocity.x, 0.0 , 0.02)
		#temple.velocity.y = lerp(temple.velocity.y, 0.0 , 0.02)
		#temple.move_and_slide()


func _on_charge_timer_timeout() -> void:
	if !temple.shooting:
		finished.emit(SHOOTING)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Charge":
		#print("works :D")
		temple.shooting = true
		finished.emit(SHOOTING)
