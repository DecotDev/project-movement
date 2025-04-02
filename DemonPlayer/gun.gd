extends Area2D

@onready
var reload_timer: Node = %ReloadTimer
@onready
var sprite: = %SpriteTest
@onready
var cross_hair: = %CrossHair

var rng: = RandomNumberGenerator.new()
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
	
	if Input.is_action_just_pressed("Shoot") and !reloading and !Global.gui_focus:
		if ammo > 0: shoot()
		else: dry_fire()
	if Input.is_action_just_pressed("Reload") and ammo != magazine_size and !reloading:
		reload()

func shoot() -> void:
	shot_sound()
	blowback()
	ammo -= 1
	gui.update_ammo_label(ammo, magazine_size)
	const BULLET = preload("res://DemonPlayer/bullet.tscn")
	var new_bullet: = BULLET.instantiate()
	if sprite.flip_v == true:
		#new_bullet.global_position = %CrossHair.global_position
		#new_bullet.global_rotation = %ShootingPoint.global_rotation
		new_bullet.global_position = %ShootingPointLeft.global_position
		new_bullet.global_rotation = %ShootingPointLeft.global_rotation
		new_bullet.global_rotation += rng.randf_range(-0.14, 0.14)
		#new_bullet.position.y -= 11
		#new_bullet.position.y -= 22
		#new_bullet.global_rotation += 0.3
		%ShootingPointLeft.add_child(new_bullet)
	else:
		#new_bullet.global_position = %CrossHair.global_position
		#new_bullet.global_rotation = %ShootingPoint.global_rotation
		new_bullet.global_position = %ShootingPointRight.global_position
		new_bullet.global_rotation = %ShootingPointRight.global_rotation
		new_bullet.global_rotation += rng.randf_range(-0.14, 0.14)
		#new_bullet.position.y -= 11
		%ShootingPointRight.add_child(new_bullet)
	eject_shell()

	
func eject_shell() -> void:
	const SHELL = preload("res://Assets/Guns/bullet_shell.tscn")
	var new_shell: = SHELL.instantiate()
	if sprite.flip_v == true:
		new_shell.global_position = %EjectionPointLeft.global_position
		new_shell.global_rotation = %EjectionPointLeft.global_rotation
		new_shell.scale.x = 2
		new_shell.scale.y = 2
		%EjectionPointLeft.add_child(new_shell)
	else:
		new_shell.global_position = %EjectionPointRight.global_position
		new_shell.global_rotation = %EjectionPointRight.global_rotation
		new_shell.scale.x = 2
		new_shell.scale.y = 2
		%EjectionPointRight.add_child(new_shell)

func shot_sound() -> void:
	SoundPlayer.play_sound(SoundPlayer.supressed_shot)

func blowback() -> void:
	if sprite.flip_v == true:
		sprite.rotation += 0.5
	else:
		sprite.rotation -= 0.5
	#print(str (sprite.rotation))
	
func blowback_reset() -> void:
	if sprite.flip_v == true:
		#sprite.rotation *= -1
		sprite.rotation = lerp(sprite.rotation, 0.0, 0.3)
	else:
		sprite.rotation = lerp(sprite.rotation, 0.0, 0.3)

func reload() -> void:
	SoundPlayer.play_sound(SoundPlayer.mag_and_rag)
	reloading = true
	gui.enable_reloading()
	reload_timer.start()
	
func dry_fire() -> void:
	SoundPlayer.play_sound(SoundPlayer.dry_fire)

func _on_reload_timer_timeout() -> void:
	ammo = magazine_size
	gui.update_ammo_label(ammo, magazine_size)
	gui.disable_reloading()
	reloading = false
