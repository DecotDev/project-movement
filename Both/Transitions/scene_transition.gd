extends CanvasLayer



func change_scene(scene: String, animation: String) -> void:
	#$AnimationPlayer.play("RESET")
	#$Dissolve.visible = false
	$PixelTransition.visible = true
	$AnimationPlayer.play(animation)
	await $AnimationPlayer.animation_finished
	if Global.world:
		$AnimationPlayer.play("DissolveHeavenOUT")
	else:
		$AnimationPlayer.play("DissolveHellOUT")
	await get_tree().create_timer(0.2).timeout
	if get_tree().paused: get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	#$AnimationPlayer.play(animation + "OUT")
	$PixelTransition.visible = false
	#$Dissolve.visible = true
	
	
	
	#if Global.world:
		#$AnimationPlayer.play("DissolveHeavenOUT")
	#else:
		#$AnimationPlayer.play("DissolveHellOUT")
		
		
		
	#$AnimationPlayer.play_backwards("Dissolve")

func play_pixel_black() -> void:
	$PixelTransition.visible = true
	$AnimationPlayer.play("PixelBlack")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("PixelBlackOUT")
