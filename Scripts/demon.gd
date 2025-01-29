extends CharacterBody2D


class_name Character

var movementSpeed: int = 40

func handleInput() -> void:
	var moveDirection: = Input.get_vector("Left","Right","Up","Down")
	velocity = moveDirection * movementSpeed
	
func _process(_delta: float) -> void:
	##Plays animation if pressed once
	#if Input.is_action_just_pressed("primaryAttack"):
		#$AnimationPlayer.play("primary")
	#if Input.is_action_pressed("primaryAttack"):
		#$AnimationPlayer.play("primary")
		#if Input.is_action_pressed("Left"):
			#$Sprite2D.flip_h = true
		#if Input.is_action_pressed("Right"):
			#$Sprite2D.flip_h = false
	#else:
		#if Input.is_action_pressed("Up"):
			#$AnimationPlayer.play("walk")
			#
		#if Input.is_action_pressed("Down"):
			#$AnimationPlayer.play("walk")
			#
		#if Input.is_action_pressed("Left"):
			#$AnimationPlayer.play("walk")
			#$Sprite2D.flip_h = true
			#
		#if Input.is_action_pressed("Right"):
			#$AnimationPlayer.play("walk")
			#$Sprite2D.flip_h = false
	handleInput()
	move_and_slide()
