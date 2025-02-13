class_name FlyingHeadState extends State

const MOVING = "Moving"
const HURT = "Hurt"

var flying_head: FlyingHead

func _ready() -> void:
	await owner.ready
	flying_head = owner as FlyingHead
	assert(flying_head != null, "The FlyingHeadState state type must be used only in the player scene. It needs the owner to be a Player node.")
