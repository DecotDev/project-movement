class_name Temple
extends CharacterBody2D

#Connections
var gui: Node = null
var demon: CharacterBody2D

#Stats
var health: int = 4 #10
var speed: int = 240
var reactivation_time: float = 2.0

#Control
var direction: Vector2
var can_lock_player: bool = true
var shooting: bool = false
var destroyed: bool = false

func _ready() -> void:
	demon = get_tree().get_root().find_child("Demon", true, false)
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	%Fire.set_deferred("visible", false)
	
func take_damage() -> void:
	if health != 0:
		if !shooting:
			%AuxAnimationPlayer.play("Hurt")
		else:
			%AuxAnimationPlayer.play("SmallHurt")
		health -= 1
	if health <= 0:
		destroyed = true
		#%DetectionArea.get_child(0).set_deferred("disabled", true)
		#%AttackArea.get_child(0).set_deferred("disabled", true)
		Global.killed_enemies += 1
		gui.update_enemies_label()
		%PatrolX.finished.emit("Destroyed")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Demon and can_lock_player:
		%PatrolX.finished.emit("Charging")

func _on_attack_area_body_exited(body: Node2D) -> void:
	if !destroyed:
		if body is Demon:
			%ReactivationTimer.start()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Demon:
		%ReactivationTimer.stop()
		%ReactivationTimer.wait_time = reactivation_time


func _on_reactivation_timer_timeout() -> void:
	%PatrolX.finished.emit("PatrolX")
