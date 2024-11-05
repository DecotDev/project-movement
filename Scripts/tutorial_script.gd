extends CharacterBody2D
class_name Player

enum { MOVE,CLIMB }
var state = MOVE
var buffered_jump = false
var coyote_jump = false
@export var moveData = preload("res://PlayerConfigs/defaultPlayerMovementData.tres") as playerMovementData
@onready var animatedSprite: = %AnimatedSprite2D
@onready var ladderCheck: = %LadderCheck
@onready var jumpBufferTimer: = %JumpBufferTimer
@onready var coyoteJumpTimer: = %CoyoteJumpTimer
var double_jump = moveData.Double_Jump_Count

func speed_up() -> void:
	moveData = load("res://PlayerConfigs/fastPlayerMovementData.tres")

func _ready() -> void:
	animatedSprite.sprite_frames = load("res://PlayerConfigs/playerGreenSkin.tres")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		MOVE: move_state(input)
		CLIMB: climb_state(input)

func move_state(input):
	if is_on_ladder() and Input.is_action_pressed("ui_up"): state = CLIMB
	
	apply_gravity()
	
	if not horizontal_move(input):
		apply_friction()
		animatedSprite.animation = "Idle"
	else:
		apply_acceleration(input.x)
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = input.x > 0
	
	if is_on_floor():
		reset_double_jump()
	else:
		animatedSprite.animation = "Jump"
		
	if can_jump():
		input_jump()
	else:
		input_jump_release()
		input_double_jump()
		buffer_jump()
		fast_fall()

	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animatedSprite.play("Run")
		animatedSprite.frame = 1
		
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()
		
func climb_state(input):
	if not is_on_ladder(): state = MOVE
	if input.length() != 0: animatedSprite.play("Run")
	else: animatedSprite.play("Idle")
	velocity = input * moveData.Climb_Speed
	move_and_slide()

func player_die():
	SoundPlayer.play_sound(SoundPlayer.HURT)
	get_tree().reload_current_scene()

func input_jump():
	if Input.is_action_just_pressed("ui_up") or buffered_jump == true:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.Jump_Force
		buffered_jump = false

func can_jump():
	return is_on_floor() or coyote_jump
	
func input_jump_release():
	if Input.is_action_just_released("ui_up") and velocity.y < moveData.Jump_Release_Force:
		velocity.y = moveData.Jump_Release_Force

func input_double_jump():
	if Input.is_action_just_pressed("ui_up") and double_jump > 0:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.Jump_Force
		double_jump -= 1

func buffer_jump():
	if Input.is_action_just_pressed("ui_up"):
		buffered_jump = true
		jumpBufferTimer.start()

func fast_fall():
	if velocity.y > 0:
		velocity.y += moveData.Additional_Gravity

func horizontal_move(input):
	return input.x != 0

func reset_double_jump():
	double_jump = moveData.Double_Jump_Count

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func apply_gravity():
	velocity.y += moveData.Gravity
	velocity.y = min(velocity.y, 290)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, moveData.Fricion)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, moveData.Max_Speed * amount, moveData.Acceleration)

func _on_jump_buffer_timer_timeout() -> void:
	buffered_jump = false # Replace with function body.

func _on_coyote_jump_timer_timeout() -> void:
	coyote_jump = false
