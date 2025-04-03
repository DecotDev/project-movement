class_name FlyingHead
extends CharacterBody2D

#Connections
@onready
var animation_player: = $AnimationPlayer
@onready
var state_label: = %StateLabel
@onready
var demon: CharacterBody2D
@onready
var moving: = %Moving
@onready
var hurt_timer: = %HurtTimer
var gui: Node = null

#Stats
var health: int = 4
var speed: int = 220

#Control
var dead: bool = false
var direction: Vector2
var rng: = RandomNumberGenerator.new()
var dir_countdown: int = 0



func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	%AnimationPlayer.play("Idle")
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	
func take_damage() -> void:
	if !dead:
		moving.finished.emit("Hurt")
	
func damage_demon() -> void:
	pass
