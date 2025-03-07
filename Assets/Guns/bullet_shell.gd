extends Sprite2D

var travelled_distance: = 0
var rng: = RandomNumberGenerator.new()
var direction: Vector2
var fase: = 1
var final_rotation: float
var falling_speed: Vector2
var speed: = 30
var falling: = true

func _ready() -> void:
	direction = Vector2(rng.randf_range(-6,6),rng.randf_range(-8,-16))
	final_rotation = rng.randf_range(0.0,360.0)

func _physics_process(delta: float) -> void:
	if falling:
		if fase == 1:
			#direction.x = lerp(direction.x, 0.0, 0.2)
			direction.y = lerp(direction.y, 0.0, 0.2)
			rotation_degrees = lerp(rotation_degrees, 180.0, 0.2)
			if direction.y > -0.3:
				z_index = 0
				fase = 0

		if fase == 0:
			falling_speed = Vector2(direction.x ,rng.randf_range(30,80) * 10)
			fase = 2
			
		if fase == 2:
			#direction.x = lerp(direction.x, falling_speed.x, 0.2)
			direction.y = lerp(direction.y, falling_speed.y, 0.03)
			if direction.y > falling_speed.x -1:
				fase = 3
			
		if fase == 3:
			direction.x = lerp(direction.x, 0.0, 0.1)
			direction.y = lerp(direction.y, 0.0, 0.1)
			#if is_equal_approx(direction.y, 0.0):
			if direction.y < 1:
				falling = false
			#rotation_degrees = lerp

		#print( str(direction.y))
		position += direction * delta * speed


func ejecting() -> void:
	direction = Vector2(rng.randf_range(-15,5),rng.randf_range(-30,-40))
	pass
