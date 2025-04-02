class_name Temple
extends CharacterBody2D

var gui: Node = null
var demon: CharacterBody2D

var speed: int = 240
var direction: Vector2

var can_lock_player: bool = true

func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	gui = get_tree().get_root().find_child("HellGUI", true, false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Demon and can_lock_player:
		%PatrolX.finished.emit("Charging")

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body is Demon:
		%ReactivationTimer.start()

func _on_reactivation_timer_timeout() -> void:
	%PatrolX.finished.emit("PatrolX")
