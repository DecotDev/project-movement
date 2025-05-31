extends CharacterBody2D

class_name Demon

@onready
var mouse_label: = %MouseLabel
@onready
var sprite: = %SpriteSuitDemon
@onready
var gun: = %Gun
@onready
var camera: = %HellCamera
@onready
var hitbox: = %Hitbox
@onready
var dash_timer: = %DashTimer
@onready
var dash_cooldown_timer: = %DashCooldownTimer
@onready
var respawn_timer: = %RespawnTimer
@onready
var aniamtion_respawn_timer: = %AnimationRespawnTimer

var speed: = 380 #was 450


var dash_available: bool = false
var gun_moved_left: bool = false
var gun_moved_right: bool = false

var input_direction: Vector2
var movement_speed: int = 24
var invencible: bool = false
var flash_invencible: bool = false

var dash_cooldown: float = 1.2

var gui: Node = null
var spawner: Node = null
#var just_respawned: bool = false

func _ready() -> void:
	sprite.z_index = 4
	
	#Global.demon_health = 1
	
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	spawner = get_tree().get_root().find_child("Spawner", true, false)

	dash_cooldown_timer.wait_time = dash_cooldown
	dash_cooldown_timer.start()
	sprite.set_instance_shader_parameter("flash_opacity", 0.0)
	await get_tree().create_timer(0.3, false).timeout
	gui.update_health_label()
	update_skills_coowldown()

func update_skills_coowldown() -> void:
	var progress: float
	if !dash_available:
		progress= (dash_cooldown_timer.time_left / dash_cooldown) * 100
	else:
		progress = 0
	gui.update_dash_cooldown_bar(progress)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("damage_demon") and !invencible:
		_recieve_damage()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("damage_demon") and !invencible:
		_recieve_damage()
		
func _recieve_damage() -> void:
	if flash_invencible: return
	Global.demon_health -= 1
	gui.update_health_label()
	if Global.demon_health > 0:
		print("Normal hit")
		SoundPlayer.play_sound(SoundPlayer.hurt_short)
		flash()
	if Global.demon_health < 1:
		aniamtion_respawn_timer.start()
		respawn_timer.start()
		%AnimationPlayer.play("Dead")
		#spawner.clear_wave()
		flash_invencible = true
		print("Player IS DEAD")
		SoundPlayer.play_sound(SoundPlayer.hurt_short)
		sprite.z_index = 6
		Global.demon_player_bloqued = true
		sprite.set_instance_shader_parameter("flash_opacity", 1.0)
		SoundPlayer.background_music_player.stop()
		
		
func flash() -> void:
	flash_invencible = true
	%FlashTimer.start()
	if Global.demon_health > 0:
		sprite.set_instance_shader_parameter("flash_opacity", 1.0)

func _on_dash_cooldown_timer_timeout() -> void:
	dash_available = true


func _on_flash_timer_timeout() -> void:
	flash_invencible = false
	sprite.set_instance_shader_parameter("flash_opacity", 0.0)


func _on_respawn_timer_timeout() -> void:
	#get_tree().reload_current_scene()
	#get_tree().unload_current_scene()
	Global.hell_respawn = true
	flash_invencible = false
	#SoundPlayer.background_music_player.stop()
	SoundPlayer.stop_all_sound()

	get_tree().reload_current_scene()

	#SceneTransition.change_scene("res://Both/MainMenu/main_menu.tscn", "PixelBlack")


func _on_animation_respawn_timer_timeout() -> void:
	SceneTransition.play_pixel_black()
	SoundPlayer.play_sfx_2(SoundPlayer.return_sound)
