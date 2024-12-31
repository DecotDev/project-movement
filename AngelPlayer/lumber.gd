class_name Player
extends CharacterBody2D

@onready
var animation_sprite = $AnimatedSprite2D
@onready
var animation_player = $AnimationPlayer
@onready
var Sprite = %Sprite2D

var speed = 550
var jump_impulse = 1400
var gravity = 4000
var acceleration = 600000
var friction = 0
var air_friction = 0
var input = Vector2.ZERO
var score = 0
