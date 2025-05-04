extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Demon:
		Global.hell_orbs += 1
		SoundPlayer.play_sound(SoundPlayer.small_orb_pickup)
		queue_free()
