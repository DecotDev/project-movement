extends Camera2D

@onready
var demon: Demon
@onready
var mouse_pos: Vector2
@onready
var mouse_demon_diff: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	demon = owner as Demon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	mouse_demon_diff = (mouse_pos - demon.global_position)
	
	#global_position = demon.global_position
	#if camera_desp():
	global_position = demon.global_position + mouse_demon_diff*0.09

func camera_desp() -> bool:
	#return (mouse_demon_diff.x > 400) or (mouse_demon_diff.x < -400) or (mouse_demon_diff.y > 200) or (mouse_demon_diff.y < -200)
	return (mouse_demon_diff.x > 90) or (mouse_demon_diff.x < -90) or (mouse_demon_diff.y > 90) or (mouse_demon_diff.y < -90)
	#return true
