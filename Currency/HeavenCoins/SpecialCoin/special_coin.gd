extends Area2D

var gui: Node = null
var collected: bool = false
var player: Node2D = null
var rng: = RandomNumberGenerator.new()
var speed: = 400.0

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)
	random_animation_start_point()

func _process(delta: float) -> void:
	if collected and player:
		var dir: = (player.global_position - global_position).normalized()
		global_position += dir * speed * delta
		#speed -= 2

func _on_body_entered(body: Player) -> void:
	if collected: return
	if body.name == "Lumber":
		collected = true
		$AnimationPlayer.stop()
		player = body
		Global.player_coins += 5
		gui.update_heaven_coins_label()
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		var scale_tween: = get_tree().create_tween()
		#var pos_tween: = get_tree().create_tween()

		scale_tween.tween_property($AnimatedSprite2D, "scale", Vector2(0,0), 0.15).set_ease(Tween.EASE_OUT)
		#pos_tween.tween_property($AnimatedSprite2D, "position", $AnimatedSprite2D.position + Vector2(12,12), 0.15)
		#.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(0.3).timeout
		self.queue_free()

func random_animation_start_point() -> void:
	var start_point: float = rng.randf_range(0.0,0.8)
	$AnimationPlayer.play("Float")
	$AnimationPlayer.seek(start_point, true)
