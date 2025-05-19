extends Area2D

var collected: bool = false
var player: Node2D = null
var speed := 350.0
var dir: Vector2

func _process(delta: float) -> void:
	if collected and player:
		dir = (player.global_position - global_position).normalized()
		global_position += dir * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Demon and !collected:
		collected = true
		player = area.get_parent()
		Global.hell_orbs += 5
		#SoundPlayer.play_sound(SoundPlayer.small_orb_pickup)
	elif area.name == "GatherDespawn" and collected:
		SoundPlayer.play_sound(SoundPlayer.big_orb_pickup)
		queue_free()
