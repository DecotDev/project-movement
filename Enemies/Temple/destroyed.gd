extends TempleState

func enter(previous_state_path: String, data := {}) -> void:
	print("e- Destroy")
	state_label.text = "Destroy"
	%Explosion.set_deferred("visible", true)
	%AnimationPlayer.play("Explosion")
	#await get_tree().create_timer(0.2).timeout
	%Sprite.set_deferred("visible", false)
	%Hurt.set_deferred("visible", false)
	%Hitbox.set_deferred("disabled", true)
	await %AnimationPlayer.animation_finished
	temple.queue_free()
