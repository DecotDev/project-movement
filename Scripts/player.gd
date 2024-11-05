extends CharacterBody2D

# Player movement variables
@export var speed: float = 500.0         # Horizontal movement speed
@export var jump_strength: float = 1800.0 # Jump force (positive for upward force in Godot 4)
@export var gravity: float = 7000.0       # Gravity applied to the player

# This function will run every frame and handle the player's movement and jumping
func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	# Apply gravity when not on the ground
	if not is_on_floor():
		%AnimatedSprite2D.play("Jumping")
		velocity.y += gravity * delta
	else:
		# If the player is on the ground and jumps
		if Input.is_action_just_pressed("ui_up"):
			%AnimatedSprite2D.play("Jumping")
			velocity.y = -jump_strength  # Negative because up is negative in 2D
			

	# Check for left and right movement inputs and update horizontal velocity
	var direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		%AnimatedSprite2D.play("Walking")
		%AnimatedSprite2D.flip_h = input.x > 0
	else:
		%AnimatedSprite2D.play("Idle")

	# Move the player based on velocity
	move_and_slide()
func horizontal_move(input):
	return input.x != 0
