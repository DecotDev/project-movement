extends Area2D

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "_on_interact")

func _on_interact() -> void:
	print("Elevator taken")
	$ElevatorTimer.start()

func _on_elevator_timer_timeout() -> void:
	if Global.world:
		transition_to_hell()
	else: 
		transition_to_heaven()

func transition_to_hell() -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")

func transition_to_heaven() -> void:
	get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
