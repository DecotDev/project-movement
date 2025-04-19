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
var orbs: Node
const SMALL_HELL_ORB: = preload("res://Currency/HellOrbs/Small/small_hell_orb.tscn")

#Stats
var health: int = 3
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
	orbs = get_tree().get_root().find_child("Orbs", true, false)
	
func take_damage() -> void:
	if !dead:
		moving.finished.emit("Hurt")
	
func damage_demon() -> void:
	pass

func gen_orb() -> void:
	if rng.randi_range(1,3) > 1:
		var new_orb: = SMALL_HELL_ORB.instantiate()
		new_orb.global_position = global_position
		orbs.add_child(new_orb)
