extends CanvasLayer



func change_scene(scene: String, animation: String) -> void:
	#$AnimationPlayer.play("RESET")
	#$Dissolve.visible = false
	$PixelTransition.visible = true
	$Dissolve.visible = true
	$AnimationPlayer.play(animation)
	await $AnimationPlayer.animation_finished
	#$AnimationPlayer.play("HidePixel")
	if Global.world:
		$AnimationPlayer.play("DissolveHeavenOUT")
	else:
		$AnimationPlayer.play("DissolveHellOUT")
	
	await get_tree().create_timer(0.2).timeout
	if get_tree().paused: get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	#$AnimationPlayer.play(animation + "OUT")
	$PixelTransition.visible = false
	
	
	
	#if Global.world:
		#$AnimationPlayer.play("DissolveHeavenOUT")
	#else:
		#$AnimationPlayer.play("DissolveHellOUT")
		
		
		
	#$AnimationPlayer.play_backwards("Dissolve")

func play_pixel_black() -> void:
	$Dissolve.color = Color(0.0,0.0,0.0,1.0)
	$PixelTransition.set_instance_shader_parameter("transition_color", Vector3(0.0, 0.0, 0.0))
	$AnimationPlayer.play("PixelBlack")
	await get_tree().create_timer(0.01,false).timeout
	$PixelTransition.visible = true
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("DissolveBlack")
