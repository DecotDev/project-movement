extends Control

var mouse_old_pos: Vector2

var quit_normal_outline: = preload("res://Both/MainMenu/Quit/QuitOutline.png")
var quit_pressed_outline: = preload("res://Both/MainMenu/Quit/QuitPressedOutline.png")
var settings_normal_outline: = preload("res://Both/MainMenu/Settings/SettingsOutline.png")
var settings_pressed_outline: = preload("res://Both/MainMenu/Settings/SettingsPressedOutline.png")
var hell_normal_outline: = preload("res://Both/MainMenu/Hell/HellOutline.png")
var hell_pressed_outline: = preload("res://Both/MainMenu/Hell/HellPressedOutline.png")

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

#Quit
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_quit_button_mouse_entered() -> void:
	$QuitButton.grab_focus()
func _on_quit_button_mouse_exited() -> void:
	$QuitButton.texture_focused = quit_normal_outline
	$QuitButton.release_focus()
func _on_quit_button_button_up() -> void:
	$QuitButton.texture_focused = quit_normal_outline
func _on_quit_button_button_down() -> void:
	$QuitButton.texture_focused = quit_pressed_outline

#Settings
func _on_settings_button_pressed() -> void:
	print("Settings to do")
func _on_settings_button_mouse_entered() -> void:
	$SettingsButton.grab_focus()
func _on_settings_button_mouse_exited() -> void:
	$SettingsButton.release_focus()
func _on_settings_button_button_up() -> void:
	$SettingsButton.texture_focused = settings_normal_outline
func _on_settings_button_button_down() -> void:
	$SettingsButton.texture_focused = settings_pressed_outline

#Hell
func _on_hell_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
func _on_hell_play_button_mouse_entered() -> void:
	$HellPlayButton.grab_focus()
	#$HeavenPlayButton.texture_hover
func _on_hell_play_button_mouse_exited() -> void:
	$HellPlayButton.release_focus()
func _on_hell_play_button_button_up() -> void:
	$HellPlayButton.texture_focused = hell_normal_outline
func _on_hell_play_button_button_down() -> void:
	$HellPlayButton.texture_focused = hell_pressed_outline






func _on_music_start_timer_timeout() -> void:
	SoundPlayer.play_menu_music()





func _on_heaven_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")


func _on_heaven_play_button_mouse_entered() -> void:
	$HeavenPlayButton.grab_focus()


func _on_heaven_play_button_mouse_exited() -> void:
	pass
	$HeavenPlayButton.release_focus()
