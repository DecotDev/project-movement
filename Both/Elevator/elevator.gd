extends Area2D

#Connections
@onready
var heaven_camera: Camera2D
@onready
var hell_camera: Camera2D
@onready
var elevator_animation_player: = %ElevatorAnimationPlayer

var bloqued: bool = false

var automatic_doors: bool = false

#@onready
#var target_cam_pos: Vector2

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "_on_interact")
	heaven_camera = get_tree().get_root().find_child("HeavenCamera", true, false)
	hell_camera = get_tree().get_root().find_child("HellCamera", true, false)
	#target_cam_pos = heaven_camera.position
	if bloqued: return
	$CanvasLayer/LeftDoor.visible = true
	$CanvasLayer/RightDoor.visible = true
	if Global.world:
		enter_to_heaven()
	else: 
		enter_to_hell()
	Global.elevator_block = true
	bloqued = true
func _on_interact() -> void:
	if bloqued: return
	bloqued = true
	$CanvasLayer/LeftDoor.visible = true
	$CanvasLayer/RightDoor.visible = true

	elevator_animation_player.play("CloseElevator")
	print("Elevator taken")
	if Global.world:
		transition_to_hell()
	else: 
		transition_to_heaven()
	$ElevatorTimer.start()

func _on_elevator_timer_timeout() -> void:
	print("Elevator timer finished")
	if Global.world:
		get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
		Global.world = false
	else: 
		get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
		Global.world = true

func transition_to_hell() -> void:
	Global.angel_player_bloqued = true
	var tween: = get_tree().create_tween()
	tween.tween_property(heaven_camera, "position", Vector2(heaven_camera.position.x,heaven_camera.position.y + 1000), 2)
	#await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("Close")
	#get_tree().change_scene_to_file("res://Hell/hell_main.tscn")

func transition_to_heaven() -> void:
	Global.demon_player_bloqued = true
	var tween: = get_tree().create_tween()
	tween.tween_property(hell_camera, "position", Vector2(hell_camera.position.x,hell_camera.position.y -1000), 2)
	$AnimationPlayer.play("Close")

	#get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
	
func enter_to_hell() -> void:
	$EnterTimer.start()
	$DoorsTimer.start()
	$AnimationPlayer.play("Open")
	print("Hell entered")
	Global.demon_player_bloqued = true
	hell_camera.position_smoothing_enabled = false
	#hell_camera.position = hell_camera.position + Vector2(0,-1000)
	hell_camera.position.x = hell_camera.get_parent().position.x
	hell_camera.position.y = hell_camera.position.y + -1000
	var tween: = get_tree().create_tween()
	tween.tween_property(hell_camera, "position", Vector2(hell_camera.get_parent().position.x,hell_camera.get_parent().position.y), 2)
	#await get_tree().create_timer(7, false).timeout
	#hell_camera.position_smoothing_enabled = false

func enter_to_heaven()-> void:
	$EnterTimer.start()
	$DoorsTimer.start()
	$AnimationPlayer.play("Open")
	print("Heaven entered")
	#var target_cam_pos: Vector2 = heaven_camera.position
	#target_cam_pos = heaven_camera.position
	Global.angel_player_bloqued = true
	heaven_camera.position_smoothing_enabled = false
	heaven_camera.position = heaven_camera.position + Vector2(0,1000)
	var tween: = get_tree().create_tween()
	tween.tween_property(heaven_camera, "position", Vector2(0,0), 2)
	await get_tree().create_timer(0.4, false).timeout
	heaven_camera.position_smoothing_enabled = true

func _on_enter_timer_timeout() -> void:
	if Global.world:
		Global.angel_player_bloqued = false
	else:
		Global.demon_player_bloqued = false
	bloqued = false
	automatic_doors = true
	Global.elevator_block = false


func _on_body_entered(body: Node2D) -> void:
	if !automatic_doors: return
	if body is Player or Demon:
		z_index = 2
		elevator_animation_player.play("OpenElevator")


func _on_body_exited(body: Node2D) -> void:
	if !automatic_doors: return
	if body is Player or Demon:
		z_index = 10
		elevator_animation_player.play("CloseElevator")


func _on_doors_timer_timeout() -> void:
	#$Sprite2D.z_index = 0
	elevator_animation_player.play("OpenElevator")


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player or Demon:
		$Sprite2D.z_index = 10
		$Case.z_index = 10


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Player or Demon:
		$Sprite2D.z_index = 0
		$Case.z_index = 0
