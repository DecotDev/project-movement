extends Area2D

var gui: Node = null
var collected: bool = false
var player: Node2D = null
var speed := 350.0
var dir: Vector2

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)
	
func _process(delta: float) -> void:
	if collected and player:
		if speed < 0: return
		if speed > 320:
			dir = (player.global_position - global_position).normalized()
		
		global_position += dir * speed * delta
		if speed > 300:
			speed -= 0.8
		else: speed -= 1

func _on_body_entered(body: Node2D) -> void:
	if collected: return
	if body.name == "Lumber":
		collected = true
		$AnimationPlayer.play("Collected")
		Global.player_emeralds += 1
		gui.update_emeralds_label()
		SoundPlayer.play_sound(SoundPlayer.emerald_pickup)
		player = body
		#fuse_to_player(body)
		var tween: = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(7,7), 1.8)
		#.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

		await get_tree().create_timer(2.4).timeout
		self.queue_free()
#
#func fuse_to_player(body: Node2D) -> void:
	#player = body
