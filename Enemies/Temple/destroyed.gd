extends TempleState

func enter(previous_state_path: String, data := {}) -> void:
	print("e- Destroy")
	state_label.text = "Destroy"
	%Fire.set_deferred("visible", true)
	%AnimationPlayer.play("Fire")
	await get_tree().create_timer(0.3).timeout
	%Sprite.set_deferred("visible", false)
	await %AnimationPlayer.animation_finished
	temple.queue_free()
