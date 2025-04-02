extends Area2D

var travelled_distance: = 0

func _physics_process(delta: float) -> void:
	const SPEED = 2000
	const RANGE = 3200
	
	var direction: = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()

#func _on_body_entered(body: Node2D) -> void:
	#queue_free()
	#if body.has_method("take_damage"):
		#body.take_damage()


func _on_body_entered(body: Node2D) -> void:
	#print(body.name)
	#if body == FlyingHead:
		#queue_free()
		#body.moving.finished.emit("Hurt")
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
		
