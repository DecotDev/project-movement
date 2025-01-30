extends Area2D

@onready
var reload_timer: Node = %ReloadTimer

var magazine_size: int = 8
var ammo: int = 8
var reloading: bool = false

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot") and !reloading:
		if ammo > 0: shoot()
	if Input.is_action_just_pressed("Reload") and ammo != magazine_size and !reloading:
		reload()

func shoot() -> void:
	ammo -= 1
	const BULLET = preload("res://Scences/bullet.tscn")
	var new_bullet: = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func reload() -> void:
	reloading = true
	reload_timer.start()

func _on_reload_timer_timeout() -> void:
	ammo = magazine_size
	reloading = false
