extends CharacterBody2D

var gravity = 82
var max_gravity = 1300
var friction = 100
var max_speed = 550
var acceleration = 180
var jump_force = -1300
var double_jumps = 1
var is_crouching = false # New flag for crouch state
var is_sliding = false
@onready var velocity_label = %VelocityLabel

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

	#if can_wall_slide():
	#	wall_slide()
	if can_wall_slide_left(): wall_slide_left()
	elif can_wall_slide_right(): wall_slide_right()
	else:
		apply_gravity()

	# Handle crouch input and prevent other animations from playing if crouching
	if can_crouch() and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down")):
		input_crouch()
	else:
		is_crouching = false # Reset crouch state if "ui_down" is not pressed
		
		if not horizontal_move(input):
			apply_friction()
			if !is_crouching and !is_sliding:
				%AnimatedSprite2D.play("Idle")
		else:
			apply_acceleration(input.x)
			if !is_crouching and !is_sliding:
				%AnimatedSprite2D.play("Run")
			%AnimatedSprite2D.flip_h = input.x < 0
		
		if can_jump():
			input_jump()  # Check for jump input

		if is_on_floor():
			double_jumps = 1  # Reset double jumps on the floor
		else:
			input_double_jump()  # Handle double jump input
			if velocity.y < 200:
				if !is_crouching and !is_sliding:
				#if !is_crouching and !is_sliding and !is_on_wall():
					%AnimatedSprite2D.play("Falling")
			else: 
				#if !is_crouching and !is_sliding:
				if !is_crouching and !is_sliding:
					%AnimatedSprite2D.play("Jumping")

	
	move_and_slide()
	velocity_label.text = "Vel Y: " + str(velocity.y) + "\nVel X: " + str(velocity.x)

func horizontal_move(input):
	return input.x != 0

func apply_gravity():
	if !is_on_wall_slide_left() and !is_on_wall_slide_right(): is_sliding = false
	#if !is_on_wall_slide(): is_sliding = false
	#if !is_on_wall(): is_sliding = false
	velocity.y += gravity
	velocity.y = min(velocity.y, max_gravity)

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
		
func wall_slide():
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.play("WallSliding")
func wall_slide_left():
	double_jumps = 1
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.flip_h = true
	#if velocity.y < -200: 	%AnimatedSprite2D.play("Jumping")
	#else: %AnimatedSprite2D.play("WallSliding")
	print(velocity.y)
	%AnimatedSprite2D.play("WallSliding")
func wall_slide_right():
	double_jumps = 1
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.flip_h = false
	print(velocity.y)
	%AnimatedSprite2D.play("WallSliding")

func can_jump():
	return is_on_floor()

func can_crouch():
	return is_on_floor()
	
"""func can_wall_slide():
	#return is_on_wall() and !is_on_floor() and (velocity.y > 200)
	return is_on_wall_slide() and !is_on_floor() and (velocity.y > 200)"""
func can_wall_slide_left():
	#return is_on_wall() and !is_on_floor() and (velocity.y > 200)
	if velocity.y < -400:
		#%AnimatedSprite2D.flip_h = true
		%AnimatedSprite2D.play("Falling")
		return false
	return is_on_wall_slide_left() and !is_on_floor() and (velocity.y > 200)
func can_wall_slide_right():
	#return is_on_wall() and !is_on_floor() and (velocity.y > 200)
	if velocity.y < -400:
		#%AnimatedSprite2D.flip_h = true
		%AnimatedSprite2D.play("Falling")
		return false
	return is_on_wall_slide_right() and !is_on_floor() and (velocity.y > 200)
	
"""func is_on_wall_slide():
	if (not %WallSlideLeft.is_colliding() or is_on_floor()) and (not %WallSlideRight.is_colliding() or is_on_floor()): return false
	var collider = %WallSlideLeft.get_collider()
	var collider2 = %WallSlideRight.get_collider()
	if (not collider is TileMapLayer) and (not collider2 is TileMapLayer): return false
	return true"""
func is_on_wall_slide_left():
	if not %WallSlideLeft.is_colliding() or is_on_floor(): return false
	var collider = %WallSlideLeft.get_collider()
	if not collider is TileMapLayer: return false
	return true
func is_on_wall_slide_right():
	if not %WallSlideRight.is_colliding() or is_on_floor(): return false
	var collider = %WallSlideRight.get_collider()
	if not collider is TileMapLayer: return false
	return true

func input_crouch():
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down"):
		if %AnimatedSprite2D.animation != "Crouch":
			%AnimatedSprite2D.play("Crouch")
		is_crouching = true
		apply_friction()
