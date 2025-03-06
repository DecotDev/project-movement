extends Area2D

@onready
var reload_timer: Node = %ReloadTimer
@onready
var sprite: = %SpriteTest

var magazine_size: int = 12
var ammo: int = 12
var reloading: bool = false
var gui: Node = null

func _ready() -> void:
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	gui.update_ammo_label(ammo, magazine_size)
	#gui.update_flame_bar(ammo)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	blowback_reset()
	if Input.is_action_just_pressed("Shoot") and !reloading:
		if ammo > 0: shoot()
	if Input.is_action_just_pressed("Reload") and ammo != magazine_size and !reloading:
		reload()

func shoot() -> void:
	shot_sound()
	blowback()
	ammo -= 1
	gui.update_ammo_label(ammo, magazine_size)
	const BULLET = preload("res://DemonPlayer/bullet.tscn")
	var new_bullet: = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func shot_sound() -> void:
	SoundPlayer.play_sound(SoundPlayer.supressed_shot)

func blowback() -> void:
	if sprite.flip_v == true:
		sprite.rotation += 0.5
	else:
		sprite.rotation -= 0.5
	print(str (sprite.rotation))
	
func blowback_reset() -> void:
	if sprite.flip_v == true:
		#sprite.rotation *= -1
		sprite.rotation = lerp(sprite.rotation, 0.0, 0.3)
	else:
		sprite.rotation = lerp(sprite.rotation, 0.0, 0.3)

func reload() -> void:
	reloading = true
	gui.enable_reloading()
	reload_timer.start()

func _on_reload_timer_timeout() -> void:
	ammo = magazine_size
	gui.update_ammo_label(ammo, magazine_size)
	gui.disable_reloading()
	reloading = false
