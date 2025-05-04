extends Control

var heart_full: = preload("res://Heaven/GUI/godot_icon.png")
var heart_empty: = preload("res://Heaven/GUI/godot_icon_black.png")

var coins_label_original_position: Vector2

@onready
var heaven_coins_label: = %HeavenCoins

func _ready() -> void:
	coins_label_original_position = heaven_coins_label.position
	update_heaven_coins_label()

func update_health_icon() -> void:
	for i in %HealthContainer.get_child_count():
		if Global.player_health > i:
			print("vida")
			%HealthContainer.get_child(i).texture = heart_full
		else:
			print("-1 vida")
			%HealthContainer.get_child(i).texture = heart_empty

func update_heaven_coins_label() -> void:
	heaven_coins_label.text = (str(Global.player_coins))
	var coin_tween: = get_tree().create_tween()
	heaven_coins_label.scale = Vector2(2,2)
	coin_tween.tween_property(heaven_coins_label, "scale", Vector2(1,1), 0.20).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var coin_pos_tween: = get_tree().create_tween()
	heaven_coins_label.position = heaven_coins_label.position - Vector2(8,18)
	coin_pos_tween.tween_property(heaven_coins_label, "position", coins_label_original_position, 0.20).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
