extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hurt()
		SoundPlayer.play_sound(SoundPlayer.spike_death)
