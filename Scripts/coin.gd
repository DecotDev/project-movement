extends Area2D


func _on_body_entered(body: Player) -> void:
	if body.name == "Lumber":
		body.score += 1
		print(body.score)
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		self.queue_free()
