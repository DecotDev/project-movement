extends Control

var heart_full: = preload("res://Heaven/GUI/godot_icon.png")
var heart_empty: = preload("res://Heaven/GUI/godot_icon_black.png")

var coins_label_original_position: Vector2

@onready
var heaven_coins_label: = %HeavenCoins
@onready
var emeralds_label: = %EmeraldsLabel
@onready
var emerald_timer: = $EmeraldTimer

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

func update_emeralds_label() -> void:
	emeralds_label.text = (str(Global.player_emeralds - 1) + "/" + str(Global.max_emeralds))
	emerald_timer.start()
	%AnimationPlayer.play("emerald_start")


func _on_emerald_timer_timeout() -> void:
	%AnimationPlayer.play("emerald_stop")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "emerald_start":
		await get_tree().create_timer(0.3).timeout
		emeralds_label.text = (str(Global.player_emeralds) + "/" + str(Global.max_emeralds))
