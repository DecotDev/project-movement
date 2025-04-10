extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Demon:
		Global.hell_orbs += 5
		queue_free()
