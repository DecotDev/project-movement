extends Control

var heart_full: = preload("res://Heaven/GUI/godot_icon.png")
var heart_empty: = preload("res://Heaven/GUI/godot_icon_black.png")

@onready
var label_coins: = %Coins

func update_health_icon() -> void:
	for i in %HealthContainer.get_child_count():
		if Global.player_health > i:
			print("vida")
			%HealthContainer.get_child(i).texture = heart_full
		else:
			print("-1 vida")
			%HealthContainer.get_child(i).texture = heart_empty
