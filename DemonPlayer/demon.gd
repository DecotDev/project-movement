extends CharacterBody2D

class_name Demon

@onready
var mouse_label: = %MouseLabel
#@onready
#var sprite: = %SpriteSuitDemon
@onready
var gun: = %Gun
@onready
var camera: = %Camera2D
@onready
var hitbox: = %Hitbox
@onready
var dash_timer: = %DashTimer
@onready
var dash_cooldown_timer: = %DashCooldownTimer

var speed: = 380 #was 450


var dash_available: bool = false
var gun_moved_left: bool = false
var gun_moved_right: bool = false

var input_direction: Vector2
var movement_speed: int = 24
var invencible: bool = false

var dash_cooldown: float = 1.2

var gui: Node = null

func _ready() -> void:
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	#gui.update_health_label()
	dash_cooldown_timer.wait_time = dash_cooldown
	dash_cooldown_timer.start()

func update_skills_coowldown() -> void:
	var progress: float
	if !dash_available:
		progress= (dash_cooldown_timer.time_left / dash_cooldown) * 100
	else:
		progress = 0
	gui.update_dash_cooldown_bar(progress)
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("damage_demon") and !invencible:
		Global.demon_health -= 1
		gui.update_health_label()
#func _physics_process(delta: float) -> void:
		#mouse_label.text = ("Char X: " + str(position.x) + "\nChar Y: " + str(position.y) + "\nMaus X: " + str(get_global_mouse_position()) + "\nCamera X: " + str(camera.position.x) + "\nCamera Y: " + str(camera.position.y) + "\nMD_df X: " + str(camera.mouse_demon_diff.x) +"\nMD_df Y: " + str(camera.mouse_demon_diff.y))
	#camera.mouse_pos = get_global_mouse_position()
	#input_direction = Input.get_vector("Left","Right","Up","Down")
	##input_direction = input_direction.normalized()
	#velocity = input_direction * 550
	#move_and_slide()
	#
	#if camera.mouse_pos.x < position.x:
		#sprite.flip_h = false
		#if !gun_moved_left:
#
			#gun.position.x = -16
			#gun_moved_left = true
			#gun_moved_right = false
	#else:
		#sprite.flip_h = true
		#if !gun_moved_right:
			#gun.position.x = + 16
			#gun_moved_left = false
			#gun_moved_right = true
#
	#if Input.is_action_just_pressed("Test"):
		#pass
	##	gun.position = Vector2(0,0)
	#
	##look_at(get_global_mouse_position())


func _on_dash_cooldown_timer_timeout() -> void:
	dash_available = true
