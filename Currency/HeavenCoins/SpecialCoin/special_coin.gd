extends Area2D
var gui: Node = null

var rng: = RandomNumberGenerator.new()

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)
	#random_animation_start_point()

func _on_body_entered(body: Player) -> void:
	if body.name == "Lumber":
		Global.player_coins += 1
		gui.update_heaven_coins_label()
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		self.queue_free()

	
#func random_animation_start_point() -> void:
	#var start_point: float = rng.randf_range(0.0,0.8)
	#$AnimationPlayer.play("Float")
	#$AnimationPlayer.seek(start_point, true)
#
