extends Area2D
var gui: Node = null

var rng: = RandomNumberGenerator.new()

func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)
	random_animation_start_point()

func _on_body_entered(body: Player) -> void:
	if body.name == "Lumber":
		Global.player_coins += 1
		gui.label_coins.text = ("Coins: " +  str(Global.player_coins))
		SoundPlayer.play_sound(SoundPlayer.pick_coin)
		self.queue_free()

func random_animation_start_time() -> void:
	$Timer.wait_time = rng.randf_range(0.1,1.8)
	$Timer.start()
	
func random_animation_start_point() -> void:
	var start_point: float = rng.randf_range(0.0,0.8)
	$AnimationPlayer.play("Float")
	$AnimationPlayer.seek(start_point, true)

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("Float")
