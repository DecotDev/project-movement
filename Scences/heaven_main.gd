extends Node2D

@onready
var heavn_gui: = %HeavenGUI

func just_a_func() -> void:
	pass


func _on_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scences/hell_main.tscn")
