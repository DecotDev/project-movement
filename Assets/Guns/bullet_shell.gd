extends Sprite2D

var travelled_distance: = 0
var rng: = RandomNumberGenerator.new()
var direction: Vector2
var fase: = 1


var speed: = 30

func _ready() -> void:
	direction = Vector2(rng.randf_range(-10,5),rng.randf_range(-8,-15))

func _physics_process(delta: float) -> void:
	
	if fase == 1:
		#direction.x = lerp(direction.x, 0.0, 0.2)
		direction.y = lerp(direction.y, 0.0, 0.2)
		if direction.y > -0.3:
			z_index = 0
			fase = 0

	if fase == 0:
		direction = Vector2(direction.x ,rng.randf_range(25,35))
		fase = 2
		
	if fase == 2:
		direction.x = lerp(direction.x, 0.0, 0.2)
		direction.y = lerp(direction.y, 0.0, 0.2)

	print( str(direction.y))
	position += direction * delta * speed


func ejecting() -> void:
	direction = Vector2(rng.randf_range(-15,5),rng.randf_range(-30,-40))
	pass
