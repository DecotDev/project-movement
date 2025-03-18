extends TileMapLayer
var rng: = RandomNumberGenerator.new()

 
 
@export var lock_pattern: = false
@export var random_int: = 0 #setget tilemap_randomization
 
 
func tilemap_randomization(random_input: int) -> void:
	if lock_pattern:
		return
 
	random_int = random_input
#    var rng = RandomNumberGenerator.new()
	rng.randomize()
 
	# Check of tool script is running on editor
	if Engine.is_editor_hint():
		for cell_position in get_used_cells():
			var num: int = 0
			if random_int != 0:
				num = rng.randi_range(0, 2)
			set_cell(cell_position, num)
 
 
# If you want to randomize on runtime:
#func _ready():
#    var rng = RandomNumberGenerator.new()
#    rng.randomize()
#
#    for cell_position in get_used_cells():
#        var num = rng.randi_range(0, 24)
#        set_cellv(cell_position, num)
