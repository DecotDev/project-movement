extends CharacterBody2D

class_name Character

@onready
var mouse_label: = %MouseLabel
@onready
var sprite: = %Sprite2D
@onready
var gun: = %Gun
@onready
var camera: = %Camera2D

var mouse_pos: Vector2
var gun_moved_left: bool = false
var gun_moved_right: bool = false

var input_direction: Vector2
var movement_speed: int = 40

func _physics_process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	input_direction = Input.get_vector("Left","Right","Up","Down")
	#input_direction = input_direction.normalized()
	velocity = input_direction * 550
	move_and_slide()
	
	if mouse_pos.x < position.x:
		sprite.flip_h = false
		if !gun_moved_left:

			gun.position.x = -16
			gun_moved_left = true
			gun_moved_right = false
	else:
		sprite.flip_h = true
		if !gun_moved_right:
			gun.position.x = + 16
			gun_moved_left = false
			gun_moved_right = true

	if Input.is_action_just_pressed("Test"):
		gun.position = Vector2(0,0)
	
	mouse_label.text = ("Char X: " + str(position.x) + "\nChar Y: " + str(position.y) + "\nMaus X: " + str(get_global_mouse_position()) + "\nCamera X: " + str(camera.position.x) + "\nCamera Y: " + str(camera.position.y))
	#look_at(get_global_mouse_position())
