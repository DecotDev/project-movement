extends Area2D
var gui: Node = null

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)

func _on_body_entered(body: Player) -> void:
	if body.name == "Lumber":
		Global.player_coins += 1
		gui.label_coins.text = ("Coins: " +  str(Global.player_coins))
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		self.queue_free()
