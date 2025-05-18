extends Area2D

@export_enum("Up", "Left", "Right", "Down") var spike_direction: String = "Up"

func _ready() -> void:
	match spike_direction:
		"Up":
			$AnimatedSprite2D.play("up")
		"Left":
			$AnimatedSprite2D.play("left")
		"Right":
			$AnimatedSprite2D.play("right")
		"Down":
			$AnimatedSprite2D.play("down")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hurt()
		SoundPlayer.play_sound(SoundPlayer.spike_death)
