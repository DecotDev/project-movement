extends PlayerState
@onready
var Sprite = %Sprite2D
#@onready
#var jump_high_timer = $".player.%JumpHighTimer"

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.jump_high_timer.start()
	player.animation_player.play("Jump")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("Left", "Right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	if input_direction_x < 0:
		Sprite.flip_h = true
	if input_direction_x > 0:
		Sprite.flip_h = false

	player.move_and_slide()

	if player.velocity.y >= 0:
		finished.emit(FALLING)

func _on_jump_high_timer_timeout() -> void:
	if !Input.is_action_pressed("Up"):
		if player.velocity.y < -500:
			player.velocity.y = -500
	else:
		print("High jump")
