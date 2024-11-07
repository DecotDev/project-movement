extends CharacterBody2D

var gravity = 100
var friction = 100
var max_speed = 550
var acceleration = 180
var jump_force = -1700
var double_jumps = 1
var is_crouching = false # New flag for crouch state

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	
	# Handle horizontal input from both Arrow keys and WASD
	if (Input.is_action_pressed("ui_left") or Input.is_action_pressed("Left")) and (Input.is_action_pressed("ui_right") or Input.is_action_pressed("Right")):
		# If both left and right are pressed, stop movement
		input.x = 0
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("Left"):
		input.x = -1
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("Right"):
		input.x = 1
	
	# Handle vertical input from both Arrow keys and WASD
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("Up"):
		input.y = -1
	elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down"):
		input.y = 1

	apply_gravity()

	# Handle crouch input and prevent other animations from playing if crouching
	if can_crouch() and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down")):
		input_crouch()
	else:
		is_crouching = false # Reset crouch state if "ui_down" is not pressed
		
		if not horizontal_move(input):
			apply_friction()
			if !is_crouching:
				%AnimatedSprite2D.play("Idle")
		else:
			apply_acceleration(input.x)
			if !is_crouching:
				%AnimatedSprite2D.play("Run")
			%AnimatedSprite2D.flip_h = input.x < 0
		
		if can_jump():
			input_jump()  # Check for jump input

		if is_on_floor():
			double_jumps = 1  # Reset double jumps on the floor
		else:
			input_double_jump()  # Handle double jump input
			if velocity.y < 200:
				if !is_crouching:
					%AnimatedSprite2D.play("Falling")
			else: 
				if !is_crouching:
					%AnimatedSprite2D.play("Jumping")
	
	move_and_slide()

func horizontal_move(input):
	return input.x != 0

func apply_gravity():
	velocity.y += gravity

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, friction)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)

func input_jump():
	# Check if W or Up is pressed for jumping, and the player is on the floor
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("Up")) and is_on_floor():
		velocity.y = jump_force

func input_double_jump():
	# Check if W or Up is pressed for double jump, and the player has double jumps available
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("Up")) and double_jumps > 0:
		velocity.y = jump_force
		double_jumps -= 1

func can_jump():
	return is_on_floor()

func can_crouch():
	return is_on_floor()

func input_crouch():
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down"):
		if %AnimatedSprite2D.animation != "Crouch":
			%AnimatedSprite2D.play("Crouch")
		is_crouching = true
		apply_friction()
