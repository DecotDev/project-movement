extends Area2D

var gui: Node = null

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Lumber":
		Global.player_emeralds += 1
		gui.update_emeralds_label()
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		self.queue_free()
