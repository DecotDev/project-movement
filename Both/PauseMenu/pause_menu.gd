extends Control

func _ready() -> void:
	hide()
	$AnimationPlayer.play("RESET")

func _process(delta: float) -> void:
	escape()

func resume() -> void:
	get_tree().paused = false
	if Global.world:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play_backwards("Blur")
	await get_tree().create_timer(0.3).timeout
	hide()
	
func pause() -> void:
	Global.save_data()
	show()
	$PanelContainer/VBoxContainer/ResumeButton.grab_focus()
	get_tree().paused = true
	if Global.world:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("Blur")

func escape() -> void:
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()

func _on_resume_button_pressed() -> void:
	resume()

func _on_settings_button_pressed() -> void:
	pass

func _on_exit_main_menu_button_pressed() -> void:
	resume()
	SoundPlayer.background_music_player.stop()
	get_tree().change_scene_to_file("res://Both/MainMenu/main_menu.tscn")
