extends CharacterBody2D

enum { MOVE }
var state = MOVE
var buffered_jump = false
var coyote_jump = false
var max_speed = 300
var acceleration = 200
var friction = 100
var double_jump = 1

# Player movement variables
@export var speed = 300
@export var jump_strength = 1800
@export var jump_release_strength = 1800
@export var gravity = 7000


# This function will run every frame and handle the player's movement and jumping
func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		MOVE: move_state(input)

func move_state(input):
	apply_gravity()
	
	if not horizontal_move(input):
		apply_friction()
		%AnimatedSprite2D.play("Idle")
	else:
		apply_acceleration(input.x)
		%AnimatedSprite2D.play("Run")
		%AnimatedSprite2D.flip_h = input.x < 0
		move_and_slide()
		
	if is_on_floor():
		reset_double_jump()
	else:
		%AnimatedSprite2D.play("Jumping")
		
	if can_jump():
		input_jump()
	else:
		input_jump_release()
		input_double_jump()
		#buffer_jump()
		#fast_fall()
	
func apply_gravity():
	velocity.y += gravity
	velocity.y = min(velocity.y, 290)
func apply_friction():
	velocity.x = move_toward(velocity.x, 1, friction)
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)
	
func horizontal_move(input):
	return input.x != 0
	
func input_jump():
	if Input.is_action_just_pressed("ui_up") or buffered_jump == true:
		#SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = jump_strength
		buffered_jump = false
func input_jump_release():
	if Input.is_action_just_released("ui_up") and velocity.y < jump_release_strength:
		velocity.y = jump_release_strength
func input_double_jump():
	if Input.is_action_just_pressed("ui_up") and double_jump > 0:
		#SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = jump_strength
		double_jump -= 1

func reset_double_jump():
	double_jump = 1
func can_jump():
	return is_on_floor() or coyote_jump
