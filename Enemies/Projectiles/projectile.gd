extends Area2D

var rng: = RandomNumberGenerator.new()

var travelled_distance: = 0
var direction: Vector2
var demon: CharacterBody2D
var charging: bool = true
var deviation: float = 0.02

const SPEED = 340
const RANGE = 2000

func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	direction = global_position.direction_to(demon.global_position)
	direction += Vector2(rng.randf_range(-deviation, deviation),rng.randf_range(-deviation, deviation))
	
	charge()
	
func charge() -> void:
	%AnimationPlayer.play("Charge")
	await %AnimationPlayer.animation_finished
	charging = false


func _physics_process(delta: float) -> void:
	if !charging:
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
