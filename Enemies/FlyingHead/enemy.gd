extends CharacterBody2D

@onready
var demon: CharacterBody2D

var health: int = 3
var direction: Vector2
var rng: = RandomNumberGenerator.new()
var dir_countdown: int = 0

#func _ready() -> void:
	#demon = get_node("/root/HellMain/Demon")
func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	%AnimationPlayer.play("Idle")

func _process(delta: float) -> void:
	#direction = global_position.direction_to(demon.global_position)
	if dir_countdown <= 0:
		direction = global_position.direction_to(demon.global_position)
		changeDirection()
		dir_countdown = rng.randf_range(20,60)
	dir_countdown -= 1
	velocity = direction * 180.0 
	move_and_slide()

func changeDirection() -> void:
	direction.x += rng.randf_range(-0.6,0.6)
	direction.y += rng.randf_range(-0.6,0.6)

func take_damage() -> void:
	%AnimationPlayer.play("Hurt")
	health -= 1
	if health <= 0:
		queue_free()
	
	
