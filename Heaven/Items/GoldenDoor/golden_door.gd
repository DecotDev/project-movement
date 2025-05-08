extends StaticBody2D

@export
var link_codes: Array[int]

@export
var closed: bool = true

func _ready() -> void:
	apply_export_var()

func apply_export_var() -> void:
	if closed:
		close_door()
	else:
		open_door()
		
func door_control() -> void:
	if closed:
		open_door()
	else:
		close_door()

func open_door() -> void:
	closed = false
	$ClosedSprite.hide()
	$ClosedCollision.set_deferred("disabled", true)
	$OpenSprite.show()
	
func close_door() -> void:
	closed = true
	$OpenSprite.hide()
	$ClosedCollision.set_deferred("disabled", false)
	$ClosedSprite.show()

func _order_recieved(link_code: int, lever_pulled: bool) -> void:
	print("Door order recieved")
	door_control()
	#text_box.finished_displaying.connect(_on_text_box_finished_displalying)
