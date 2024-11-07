extends CharacterBody2D

var gravity = 100
var friction = 100
var max_speed = 550
var acceleration = 180
var jump_force = -1700
var double_jumps = 1
var is_crouching = false

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	apply_gravity()
	#if vertical_move(input) and is_on_floor():
	#	%AnimatedSprite2D.play("Crouch")
	
	if not horizontal_move(input):
		apply_friction()
		%AnimatedSprite2D.play("Idle")
	else:
		apply_acceleration(input.x)
		%AnimatedSprite2D.play("Run")
		%AnimatedSprite2D.flip_h = input.x < 0
	if can_crouch() and Input.is_action_pressed("ui_down"):
		input_crouch()
	else:
		is_crouching = false
		
	if can_jump():
		input_jump()
	if is_on_floor():
		double_jumps = 1
	else:
		input_double_jump()
		if (velocity.y < 200 ):
			%AnimatedSprite2D.play("Falling")
		else: %AnimatedSprite2D.play("Jumping")
	
	move_and_slide()

func horizontal_move(input):
	return input.x != 0
func vertical_move(input):
	return input.y < 0
func apply_gravity():
	velocity.y += gravity
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, friction)
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)
func input_jump():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

func input_double_jump():
	if Input.is_action_just_pressed("ui_up") and double_jumps > 0:
		velocity.y = jump_force
		double_jumps -= 1
func can_jump():
	return is_on_floor()
func can_crouch():
	return is_on_floor()
func input_crouch():
	if Input.is_action_pressed("ui_down"):
		if %AnimatedSprite2D.animation != "Crouch":
			%AnimatedSprite2D.play("Crouch")
	is_crouching = true
