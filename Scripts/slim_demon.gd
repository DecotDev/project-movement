extends CharacterBody2D

var gravity: = 82
var max_gravity: = 1300
var friction: = 100
var max_speed: = 550
var acceleration: = 180
var jump_force: = -1300
var double_jumps: = 1
var is_crouching: = false # New flag for crouch state
var is_sliding: = false
var coyote_jump: = false
var was_on_floor: = false
var just_left_ground: = false
var dash_available: = false
var dash_force: = 3.6
var dashing: = false
var old_input: = 0

@onready var velocity_label: = %VelocityLabel

func _physics_process(delta: float) -> void:
	var input: = Vector2.ZERO

	
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

	if input.x != 0: old_input = input.x
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
			if !dashing: apply_acceleration(input.x)
			if !is_crouching and !is_sliding:
				%AnimatedSprite2D.play("Run")
			%AnimatedSprite2D.flip_h = input.x < 0
		
		if can_jump():
			input_jump()  # Check for jump input
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
		if is_on_floor():
			double_jumps = 1  # Reset double jumps on the floor


	was_on_floor = is_on_floor()
	
	input_dash(old_input)
	#if dashing:
	#	print(velocity.x)
		
	
	'''MOVE AND SLIDE'''
	
	move_and_slide()
	
	just_left_ground = not is_on_floor() and was_on_floor
	#if just_left_ground and velocity.y >= 0:
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		%CoyoteJumpTimer.start()
	velocity_label.text = "Vel Y: " + str(velocity.y) + "\nVel X: " + str(velocity.x) + "\nCoyote: " + str(coyote_jump) + "\nTimer: " + str(%CoyoteJumpTimer.time_left)

func horizontal_move(input: Vector2) -> bool:
	return input.x != 0

func apply_gravity() -> void:
	if !is_on_wall_slide_left() and !is_on_wall_slide_right(): is_sliding = false
	#if !is_on_wall_slide(): is_sliding = false
	#if !is_on_wall(): is_sliding = false
	velocity.y += gravity
	velocity.y = min(velocity.y, max_gravity)

func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, friction)

func apply_acceleration(amount: int) -> void:
	#print("before vel = " + str(velocity.x))
	#print("before acc = " + str(acceleration))
	#print("before direction = " + str(amount))
	#print("before maxspeed = " + str(max_speed))
	
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)
	#print("after vel = " + str(velocity.x))

func input_jump() -> void:
	# Check if W or Up is pressed for jumping, and the player is on the floor
	#if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("Up")) and is_on_floor():
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("Up")):
		coyote_jump = false
		#%CoyoteJumpTimer.stop()
		velocity.y = jump_force

func input_double_jump() -> void:
	# Check if W or Up is pressed for double jump, and the player has double jumps available
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("Up")) and double_jumps > 0:
		#coyote_jump = false
		velocity.y = jump_force
		double_jumps -= 1
		
func input_dash(input: int) -> void:
	if (Input.is_action_just_pressed("Shift")) and can_dash():
		dash_available = false
		%DashRefresh.start()
		%DashDuration.start()
		dashing = true
		#velocity.x = velocity.x * dash_force
		velocity.x = (550 * input) * dash_force
		
		

func wall_slide() -> void:
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.play("WallSliding")
func wall_slide_left() -> void:
	double_jumps = 1
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.flip_h = true
	#if velocity.y < -200: 	%AnimatedSprite2D.play("Jumping")
	#else: %AnimatedSprite2D.play("WallSliding")
	%AnimatedSprite2D.play("WallSliding")
func wall_slide_right() -> void:
	double_jumps = 1
	is_sliding = true
	velocity.y += gravity
	velocity.y = min(velocity.y, 200)
	%AnimatedSprite2D.flip_h = false
	#print(velocity.y)
	%AnimatedSprite2D.play("WallSliding")

func can_jump() -> bool:
	return is_on_floor() or coyote_jump

func can_crouch() -> bool:
	return is_on_floor()
	
func can_wall_slide_left() -> bool:
	#return is_on_wall() and !is_on_floor() and (velocity.y > 200)
	if velocity.y < -400:
		#%AnimatedSprite2D.flip_h = true
		%AnimatedSprite2D.play("Falling")
		return false
	return is_on_wall_slide_left() and !is_on_floor() and (velocity.y > 200)
func can_wall_slide_right() -> bool:
	#return is_on_wall() and !is_on_floor() and (velocity.y > 200)
	if velocity.y < -400:
		#%AnimatedSprite2D.flip_h = true
		%AnimatedSprite2D.play("Falling")
		return false
	return is_on_wall_slide_right() and !is_on_floor() and (velocity.y > 200)
	
func can_dash() -> bool:
	return dash_available

func is_on_wall_slide_left() -> bool:
	if not %WallSlideLeft.is_colliding() or is_on_floor(): return false
	var collider: Node = %WallSlideLeft.get_collider()
	if not collider is TileMapLayer: return false
	return true
func is_on_wall_slide_right() -> bool:
	if not %WallSlideRight.is_colliding() or is_on_floor(): return false
	var collider: Node = %WallSlideRight.get_collider()
	if not collider is TileMapLayer: return false
	return true

func input_crouch() -> void:
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("Down"):
		if %AnimatedSprite2D.animation != "Crouch":
			%AnimatedSprite2D.play("Crouch")
		is_crouching = true
		apply_friction()


func _on_coyote_jump_timer_timeout() -> void:
	coyote_jump = false 


func _on_dash_timer_timeout() -> void:
	dash_available = true

func _on_dash_duration_timeout() -> void:
	dashing = false
