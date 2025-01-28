extends Control

var heart_full: = preload("res://Assets/Heaven/GUI/godot_icon.png")
var heart_empty: = preload("res://Assets/Heaven/GUI/godot_icon_black.png")

func update_health_icon() -> void:
	for i in get_child_count():
		if Global.player_health > i:
			print("vida")
			#get_child(i).texture = heart_full
		else:
			print("-1 vida")
			#get_child(i).texture = heart_empty
