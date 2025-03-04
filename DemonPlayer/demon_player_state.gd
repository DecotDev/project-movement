class_name DemonPlayerState extends State

const MOVING_SHOOTING = "MovingShooting"
const ROLL = "Roll"

var demon: Demon

@onready
var state_label: = %StateLabel
@onready
var animation_player: = %AnimationPlayer
@onready
var sprite_s_d: = %SpriteSD

func _ready() -> void:
	await owner.ready
	demon = owner as Demon
	assert(demon != null, "The FlyingHeadState state type must be used only in the player scene. It needs the owner to be a Player node.")
