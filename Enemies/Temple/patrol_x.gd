extends TempleState

var horizontal: bool = true
var down: bool = true
var up: bool = true
var left: bool = true
var right: bool = true
var last_h: bool = false

func enter(previous_state_path: String, data := {}) -> void:
	temple.shooting = false
	#print("e- Patrol X")
	#print("shooting: " + str(temple.shooting))
	temple.can_lock_player = true
	temple.direction = Vector2(0,0)
	if temple.spawning:
		%AuxAnimationPlayer.play("Spawn")
		temple.spawn_timer.start()
	else:
		%AnimationPlayer.play("Jiggle")
		%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 1
	state_label.text = "Patrol X"
	right = false
	left = false

func physics_update(delta: float) -> void:
	demon_direction = temple.global_position.direction_to(temple.demon.global_position)
	#temple.direction = temple.global_position.direction_to(temple.demon.global_position)
	%DirectionLabel.text = ("X: " + str(demon_direction.x) +  " Y: " + str(demon_direction.y))
	
	if demon_direction.x > 0:
		temple.direction.x = 1
		right = true
	elif demon_direction.x < 1:
		temple.direction.x = -1
		left = true

	if right and left:
		temple.direction = Vector2(0,0)
		finished.emit(PATROL_Y)
		
	temple.velocity = temple.direction * temple.speed
	temple.move_and_slide()

	#flying_head.animation_player.play("Hurt")
	#push_back()
	#flying_head.health -= 1
	#if flying_head.health <= 0:
		#Global.killed_enemies += 1
		#flying_head.gui.update_enemies_label()
		#flying_head.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if !temple.spawning: return
	if anim_name == "Spawn":
		temple.spawning = false
		%AnimationPlayer.play("Jiggle")
		%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 1


func _on_spawn_timer_timeout() -> void:
	if temple.spawning:
		temple.spawning = false
		%AnimationPlayer.play("Jiggle")
		%AnimationPlayer.get_animation(%AnimationPlayer.current_animation).loop_mode = 1
