extends DemonPlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Idle state entered health: " + str(Global.demon_health))
	if Global.demon_health < 1: return
	state_label.text = "Idle"
	%AnimationPlayer.play("Idle")
	demon.velocity = Vector2(0,0)
	demon.move_and_slide()
	

func physics_update(delta: float) -> void:
	if Global.demon_player_bloqued == true: return
	demon.camera.mouse_pos = demon.get_global_mouse_position()
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

	#if Input.is_action_just_pressed("Space"):
		#finished.emit(DASH)

	if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right") or Input.is_action_pressed("Up") or Input.is_action_pressed("Down")) and !((Input.is_action_pressed("Left") and Input.is_action_pressed("Right")) or (Input.is_action_pressed("Up") and Input.is_action_pressed("Down"))):
		finished.emit(MOVING_SHOOTING)



func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
	#if body.has_method("damage_demon"):
		#Global.demon_health -= 1
		#demon.gui.update_health_label()
