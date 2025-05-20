extends StaticBody2D

@export
var link_codes: Array[int]
@export
var id: int

@export
var closed: bool = true

const door_open: = preload("res://Heaven/Items/GoldenDoor/DoorOpen.wav")
const door_close: = preload("res://Heaven/Items/GoldenDoor/DoorClose.wav")


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
		play_2d_sound(door_open)
	else:
		close_door()
		play_2d_sound(door_open)

func open_door() -> void:
	#play_2d_sound(door_open)
	#SoundPlayer.play_2d_sound(SoundPlayer.door_open,5)
	#SoundPlayer.play_sound(SoundPlayer.door_open)
	closed = false
	$ClosedSprite.hide()
	$ClosedCollision.set_deferred("disabled", true)
	$OpenSprite.show()
	
func close_door() -> void:
	#play_2d_sound(door_open)
	#SoundPlayer.play_2d_sound(SoundPlayer.door_close,5)
	#SoundPlayer.play_2d_sound(SoundPlayer.projectile_fly,5)

	#SoundPlayer.play_sound(SoundPlayer.door_close)
	closed = true
	$OpenSprite.hide()
	$ClosedCollision.set_deferred("disabled", false)
	$ClosedSprite.show()

func _order_recieved(link_code: int, lever_pulled: bool) -> void:
	print("Door order recieved")
	door_control()
	#text_box.finished_displaying.connect(_on_text_box_finished_displalying)

func play_2d_sound(sound: AudioStream) -> void:
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()
