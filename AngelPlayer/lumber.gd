class_name Player
extends CharacterBody2D

@onready
var animation_sprite = $AnimatedSprite2D
@onready
var animation_player = $AnimationPlayer
@onready
var Sprite = %Sprite2D
@onready
var jump_high_timer = %JumpHighTimer
@onready
var jump_buffer_timer = %JumpBufferTimer
@onready
var jump_buffer_wait_timer = %JumpBufferWaitTimer
@onready
var coyote_timer = %CoyoteTimer
@onready
var state_label = %StateLabel
@onready
var Vel_Y_label = %VelYLabel

#var speed = 550
var speed = 600
#var jump_impulse = 1400
#var gravity = 4000
var jump_impulse = 1400
var gravity = 4000
var fast_fall_vel = 200
var past_vel_y = 0
var max_y_speed = 1300
#var acceleration = 600000
var friction = 0
var air_friction = 0
var input = Vector2.ZERO
var score = 0
var buffered_jump = false
var coyote_jump = false
var was_on_floor = false
