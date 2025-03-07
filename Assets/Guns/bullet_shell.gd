extends Sprite2D

var travelled_distance: = 0
var rng: = RandomNumberGenerator.new()
var direction: Vector2

var speed: = 30

func _ready() -> void:
	direction = Vector2(rng.randf_range(-20,15),rng.randf_range(-8,-25))

func _physics_process(delta: float) -> void:
	

	direction.x = lerp(direction.x, 0.0, 0.2)
	direction.y = lerp(direction.y, 0.0, 0.2)

	position += direction * delta * speed

	if is_equal_approx(direction.y, 0.0):
		z_index = 0
func ejecting() -> void:
	direction = Vector2(rng.randf_range(-15,5),rng.randf_range(-20,-30))
	pass
