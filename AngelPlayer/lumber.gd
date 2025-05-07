class_name Player
extends CharacterBody2D

@onready
var animation_sprite: = $AnimatedSprite2D
@onready
var animation_player: = $AnimationPlayer
@onready
var sprite: = %Sprite2D
@onready
var jump_high_timer: = %JumpHighTimer
@onready
var jump_buffer_timer: = %JumpBufferTimer
@onready
var jump_buffer_wait_timer: = %JumpBufferWaitTimer
@onready
var coyote_timer: = %CoyoteTimer
@onready
var state_label: = %StateLabel
@onready
var vel_y_label: = %VelYLabel
@onready
var vel_x_label: = %VelXLabel
@onready
var dash_label: = %DashLabel
@onready
var dash_finish_timer: = %DashFinishTimer
@onready
var dash_fall_impulse_timer: = %DashFallImpulseTimer
@onready
var hurt_timer: = %HurtTimer
@onready
var respawn_timer: = %RespawnTimer

@onready
var hurt_state: = %Hurt

#var speed = 550
var speed: int = 560 #600
#var jump_impulse = 1400
#var gravity = 4000
var jump_impulse: int = 1400
var gravity: int = 4000
var fast_fall_vel: int = 200
#var past_vel_y: int = 0
var dash_impulse: int = 520 #540
var dash_impulse_reset: int = 520 #540
var max_y_speed: int = 1300
#var acceleration = 600000
var friction: int = 0
var air_friction: int = 0
var input: Vector2 = Vector2.ZERO
#var score: int = 0
var buffered_jump: bool = false
var coyote_jump: bool = false
var was_on_floor: bool = false
var just_dashed: bool = false
var dash_slow_fall: int = 0
var just_respawned: bool = false
var last_angel_position: Array[Vector2] = [Vector2(-4539.0, 1367.0),Vector2(-4539.0, 1367.0),Vector2(-4539.0, 1367.0)]
var last_floor_position: Vector2 = Vector2(-4539.0, 1367.0)
var old_last_floor_position: Vector2 = Vector2(-4539.0, 1367.0)
var just_hit: = false

func get_hurt() -> void:
	hurt_state.finished.emit("Hurt")
