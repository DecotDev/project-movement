extends Node2D

@onready
var heaven_gui: = %HeavenGUI

func just_a_func() -> void:
	pass

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
