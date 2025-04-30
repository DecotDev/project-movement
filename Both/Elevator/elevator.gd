extends Area2D

#Connections
@onready
var heaven_camera: Camera2D
@onready
var hell_camera: Camera2D

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "_on_interact")
	heaven_camera = get_tree().get_root().find_child("HeavenCamera", true, false)
	hell_camera = get_tree().get_root().find_child("HellCamera", true, false)

func _on_interact() -> void:
	print("Elevator taken")
	if Global.world:
		transition_to_hell()
	else: 
		transition_to_heaven()
	$ElevatorTimer.start()

func _on_elevator_timer_timeout() -> void:
	if Global.world:
		get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
	else: 
		get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")

func transition_to_hell() -> void:
	Global.angel_player_bloqued = true
	var tween: = get_tree().create_tween()
	tween.tween_property(heaven_camera, "position", Vector2(heaven_camera.position.x,heaven_camera.position.y + 1000), 2)
	#get_tree().change_scene_to_file("res://Hell/hell_main.tscn")

func transition_to_heaven() -> void:
	Global.demon_player_bloqued = true
	var tween: = get_tree().create_tween()
	tween.tween_property(hell_camera, "position", Vector2(hell_camera.position.x,hell_camera.position.y -1000), 2)
	#get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
