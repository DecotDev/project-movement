extends CanvasLayer

func change_scene(scene: String, animation: String) -> void:
	$AnimationPlayer.play(animation)
	await $AnimationPlayer.animation_finished
	if get_tree().paused: get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	$AnimationPlayer.play(animation + "OUT")
