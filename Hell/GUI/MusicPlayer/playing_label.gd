#extends Label
#
#var speed: = 50  # Adjust speed as needed
#var start_pos: float
#var end_pos: float
#
#func _ready() -> void:
	#start_pos = position.x
	#end_pos = start_pos - (self.size.x - get_parent().size.x)
#
#func _process(delta: float) -> void:
	#position.x -= speed * delta  # Move left
	#if position.x <= end_pos:  # Reset position when it reaches the end
		#position.x = start_pos
