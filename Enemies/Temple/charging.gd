extends TempleState

var velocity_x: int
var velocity_y: int

func enter(previous_state_path: String, data := {}) -> void:
	temple.can_lock_player = false
	print("e- Charging")
	print("shooting: " + str(temple.shooting))
	if %AnimationPlayer.current_animation == "Jiggle":
		%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 0
		await %AnimationPlayer.animation_finished
	state_label.text = "Charging"
	%AnimationPlayer.play("Charge")

func physics_update(delta: float) -> void:
	demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	%VelocityLabel.text = ("X: " + str(temple.velocity.x) +  " Y: " + str(temple.velocity.y))
	velocity_x = temple.velocity.x
	velocity_y = temple.velocity.y
	if velocity_x == 10 or velocity_y == 10 or velocity_x == -10 or velocity_y == -10:
		if %AnimationPlayer.is_playing():
			await %AnimationPlayer.animation_finished
		if !temple.shooting:
			finished.emit(SHOOTING)
	else:
		temple.velocity.x = lerp(temple.velocity.x, 0.0 , 0.02)
		temple.velocity.y = lerp(temple.velocity.y, 0.0 , 0.02)
		temple.move_and_slide()
