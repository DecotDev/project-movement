extends Area2D

var rng: = RandomNumberGenerator.new()

var travelled_distance: = 0
var direction: Vector2
var demon: CharacterBody2D
var charging: bool = true
var deviation: float = 0.02
var creator: Node

const SPEED = 480
const RANGE = 2000

func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	if creator and creator.has_signal("about_to_be_destroyed"):
		creator.about_to_be_destroyed.connect(_on_creator_destroyed)
		print("signal connected")
	else:
		print("signal not connected")
	#direction = global_position.direction_to(demon.global_position)
	#direction += Vector2(rng.randf_range(-deviation, deviation),rng.randf_range(-deviation, deviation))
	
	charge()
	
func charge() -> void:
	%AnimationPlayer.play("Charge")
	await %AnimationPlayer.animation_finished
	direction = global_position.direction_to(demon.global_position)
	direction += Vector2(rng.randf_range(-deviation, deviation),rng.randf_range(-deviation, deviation))
	charging = false
	


func _physics_process(delta: float) -> void:
	if charging:
		pass
		#if not is_instance_valid(creator):
			#queue_free()
	else:
		position += direction * SPEED * delta
		travelled_distance += SPEED * delta

		if travelled_distance > RANGE:
			queue_free()

#func _on_body_entered(body: Node2D) -> void:
	#queue_free()
	#if body.has_method("take_damage"):
		#body.take_damage()


func _on_body_entered(body: Node2D) -> void:
	#print(body.name)
	#if body == FlyingHead:
		#queue_free()
		#body.moving.finished.emit("Hurt")
		
		
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()

func _on_creator_destroyed() -> void:
	if charging:
		queue_free()

func damage_demon() -> void:
	pass
