extends Node2D




func _on_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scences/world.tscn")
