extends StaticBody2D

func open_door() -> void:
	$ClosedSprite.hide()
	$ClosedCollision.set_deferred("disabled", true)
	$OpenSprite.show()
