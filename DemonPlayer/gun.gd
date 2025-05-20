extends Area2D

var bullet_shells: Node = null

@onready
var reload_timer: Timer = %ReloadTimer
@onready
var fire_rate_timer: Timer = %FireRateTimer
@onready
var fire_mode_timer: Timer = %FireModeTimer
@onready
var sprite: = %SpriteTest
@onready
var cross_hair: = %CrossHair

var rng: = RandomNumberGenerator.new()
var magazine_size: int = 12
var ammo: int = 12
var reloading: bool = false
var fire_rate_wait: = false
var gui: Node = null
var dry_fire_counter: int = 0
var full_auto: bool = true
var fire_mode_wait: bool = false

func _ready() -> void:
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	bullet_shells = get_tree().get_root().find_child("BulletShells", true, false)
	gui.update_ammo_label(ammo, magazine_size)

func _physics_process(delta: float) -> void:
	if Global.demon_player_bloqued == true: return
	
	look_at(get_global_mouse_position())
	blowback_reset()
	
	if Input.is_action_just_pressed("B") and !fire_mode_wait:
		change_firing_mode()
	
	if full_auto: 
		if Input.is_action_pressed("Shoot") and !reloading and!fire_rate_wait and !Global.gui_focus:
			fire_rate_timer.start()
			fire_rate_wait = true
			if ammo > 0: shoot()
			elif dry_fire_counter >= 2:
				reload()
			else: 
				dry_fire()
	
	else:
		if Input.is_action_just_pressed("Shoot") and !reloading and !Global.gui_focus:
			#print(str(dry_fire_counter))
			if ammo > 0: shoot()
			elif dry_fire_counter >= 2:
				reload()
			else: 
				dry_fire()
			
	if (Input.is_action_just_pressed("Reload") or Input.is_action_just_pressed("RightMouse") ) and ammo != magazine_size and !reloading:
		reload()
		
func change_firing_mode() -> void:
	fire_mode_timer.start()
	fire_mode_wait = true
	SoundPlayer.play_sound(SoundPlayer.gun_mode_click)
	if full_auto:
		full_auto = false
	else:
		full_auto = true
	gui.update_fire_mode_label(full_auto)
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
		bullet_shells.add_child(new_shell)
		#%EjectionPointLeft.add_child(new_shell)
	else:
		new_shell.global_position = %EjectionPointRight.global_position
		new_shell.global_rotation = %EjectionPointRight.global_rotation
		new_shell.scale.x = 2
		new_shell.scale.y = 2
		bullet_shells.add_child(new_shell)
		#%EjectionPointRight.add_child(new_shell)

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
	Global.save_data()
	SoundPlayer.play_sound(SoundPlayer.mag_and_rag)
	reloading = true
	gui.enable_reloading()
	reload_timer.start()
	
func dry_fire() -> void:
	SoundPlayer.play_sound(SoundPlayer.dry_fire)
	dry_fire_counter += 1

func _on_reload_timer_timeout() -> void:
	dry_fire_counter = 0
	ammo = magazine_size
	gui.update_ammo_label(ammo, magazine_size)
	gui.disable_reloading()
	reloading = false


func _on_fire_rate_timer_timeout() -> void:
	fire_rate_wait = false

func _on_fire_mode_timer_timeout() -> void:
	fire_mode_wait = false
