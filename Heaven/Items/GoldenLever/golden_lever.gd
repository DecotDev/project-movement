extends Node2D

@onready
var linked_doors: = get_parent().get_node("HeavenDoors")

@export
var pulled: bool = false
@export var link_code: int
signal lever_just_pulled()

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "_on_interact")
	link_codes()
	apply_export_var()
	
func apply_export_var() -> void:
	if !pulled:
		set_unpull()
	else:
		set_pull()

func _on_interact() -> void:
	lever_control()

func lever_control() -> void:
	SoundPlayer.play_sound(SoundPlayer.lever)
	if !pulled:
		pull()
	else:
		unpull()


func pull() -> void:
	pulled = true
	$Lever.frame = 1
	#$Center.hide()
	#$Right.show()
	emit_signal("lever_just_pulled", link_code, pulled)
	
func unpull() -> void:
	pulled = false
	$Lever.frame = 0
	#$Right.hide()
	#$Center.show()
	emit_signal("lever_just_pulled", link_code, pulled)

func link_codes() -> void:
	if link_code != 0:
		for door in linked_doors.get_children():
			for door_link_code: int in door.link_codes:
				if door_link_code == link_code:
					connect("lever_just_pulled", Callable(door, "_order_recieved"))
					#print("linked succesfully")
	else: print("error linking")


func set_pull() -> void:
	pulled = true
	$Lever.frame = 1
	#$Center.hide()
	#$Right.show()
	
func set_unpull() -> void:
	pulled = false
	$Lever.frame = 0
	#$Right.hide()
	#$Center.show()
