extends CharacterBody2D


class_name Character
var input_direction_x: float
var movement_speed: int = 40
var last_movement: = Vector2.UP


func movement() -> void:
	var x_mov: = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var y_mov: = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	var mov: = Vector2(x_mov,y_mov)
	if mov.x > 0:
		$Sprite2D.flip_h = true
	elif mov.x < 0:
		$Sprite2D.flip_h = false

	if mov != Vector2.ZERO:
		last_movement = mov
		#if walkTimer.is_stopped():
			#if sprite.frame >= sprite.hframes - 1:
				#sprite.frame = 0
			#else:
				#sprite.frame += 1
			#walkTimer.start()
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()
func physics_process(delta: float) -> void:
	movement()
	#input_direction_x = Input.get_axis("Left","Right")
	#velocity.x = 80 * input_direction_x 
	#move_and_slide()
 
