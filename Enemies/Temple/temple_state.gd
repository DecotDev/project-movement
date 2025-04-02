class_name TempleState extends State

const PATROL_X = "PatrolX"
const PATROL_Y = "PatrolY"
const CHARGING = "Charging"
const SHOOTING = "Shooting"

var temple: Temple

@onready
var state_label: = %StateLabel

var demon_direction: Vector2

func _ready() -> void:
	await owner.ready
	temple = owner as Temple
	assert(temple != null, "The TempleState state type must be used only in the player scene. It needs the owner to be a Player node.")
