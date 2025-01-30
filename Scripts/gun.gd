extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func shoot() -> void:
	const BULLET = preload("res://Scences/bullet.tscn")
	var new_bullet: = BULLET.instantiate()
	new_bullet.position = %ShootingPoint.position
	new_bullet.rotation = %ShootingPoint.rotation
	%ShootingPoint.add_child(new_bullet)
