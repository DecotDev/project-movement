extends CharacterBody2D

var gravity = 100
var friction = 100
var max_speed = 400
var acceleration = 180
var jump_force = -1500
var double_jumps = 1

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	#input.y = Input.get_axis("ui_up", "ui_down")
	
	apply_gravity()
	
	if not horizontal_move(input):
		apply_friction()
		%AnimatedSprite2D.play("Idle")
	else:
		apply_acceleration(input.x)
		%AnimatedSprite2D.play("Run")
		%AnimatedSprite2D.flip_h = input.x < 0
	
	input_jump()
	if is_on_floor():
		double_jumps = 1
	else:
		input_double_jump()
	
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
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
func input_double_jump():
	if Input.is_action_just_pressed("ui_up") and double_jumps > 0:
		velocity.y = jump_force
		double_jumps -= 1
