extends CharacterBody2D


class_name Character
var input_direction: Vector2
var movement_speed: int = 40


func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("Left","Right","Up","Down")
	#input_direction = input_direction.normalized()
	velocity = input_direction * 550
	move_and_slide()
	
	#look_at(get_global_mouse_position())

 
