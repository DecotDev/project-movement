extends Control

var mouse_old_pos: Vector2

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$HeavenPlayButton.grab_focus()
	$MusicStartTimer.start()
	mouse_old_pos = get_global_mouse_position()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_old_pos == get_global_mouse_position()
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		Input.warp_mouse(Vector2(980,400))
		
	elif mouse_old_pos != get_global_mouse_position() or !get_global_mouse_position() == Vector2(980,400):
		print("visible")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_old_pos = get_global_mouse_position()
	elif mouse_old_pos == get_global_mouse_position():
		print("same pos")
		if get_global_mouse_position() == Vector2(980,400):
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	else:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		mouse_old_pos = get_global_mouse_position()

func _on_settings_button_pressed() -> void:
	print("Settings to do")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_music_start_timer_timeout() -> void:
	SoundPlayer.play_menu_music()


func _on_hell_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")


func _on_heaven_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")


func _on_heaven_play_button_mouse_entered() -> void:
	$HeavenPlayButton.grab_focus()


func _on_heaven_play_button_mouse_exited() -> void:
	pass
	#$HeavenPlayButton.release_focus()


func _on_hell_play_button_mouse_entered() -> void:
	$HellPlayButton.grab_focus()
	$HeavenPlayButton.texture_hover


func _on_hell_play_button_mouse_exited() -> void:
	pass
	#$HellPlayButton.release_focus()


func _on_settings_button_mouse_entered() -> void:
	$SettingsButton.grab_focus()


func _on_settings_button_mouse_exited() -> void:
	pass
	#$SettingsButton.release_focus()


func _on_quit_button_mouse_entered() -> void:
	$QuitButton.grab_focus()


func _on_quit_button_mouse_exited() -> void:
	pass
	#$QuitButton.release_focus()
