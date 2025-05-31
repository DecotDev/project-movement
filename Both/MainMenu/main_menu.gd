extends Control

var mouse_old_pos: Vector2
var focus: bool = false
var mouse: bool = true
var mouse_on_button: bool = false
var pressed: bool = false

var quit_normal_outline: = preload("res://Both/MainMenu/Quit/QuitOutline.png")
var quit_pressed_outline: = preload("res://Both/MainMenu/Quit/QuitPressedOutline.png")
var settings_normal_outline: = preload("res://Both/MainMenu/Settings/SettingsOutline.png")
var settings_pressed_outline: = preload("res://Both/MainMenu/Settings/SettingsPressedOutline.png")
var hell_normal_outline: = preload("res://Both/MainMenu/HellButton/HellOutline.png")
var hell_pressed_outline: = preload("res://Both/MainMenu/HellButton/HellPressedOutline.png")
var heaven_normal_outline: = preload("res://Both/MainMenu/HeavenButton/HeavenOutline.png")
var heaven_pressed_outline: = preload("res://Both/MainMenu/HeavenButton/HeavenPressedOutline.png")

func _ready() -> void:
	$TitleWaveTimer.start()
	wave_animation()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$MusicStartTimer.start()
	mouse_old_pos = get_global_mouse_position()
	
	Global.load_data()
	#RESTE EMERALDS
	Global.player_emeralds = 0
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		SoundPlayer.play_sfx_1(SoundPlayer.select)
		mouse_old_pos == get_global_mouse_position()
		mouse = false
		if !focus:
			$HeavenPlayButton.grab_focus()
			focus = true
		focus = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		Input.warp_mouse(Vector2(980,400))
		
	elif mouse_old_pos != get_global_mouse_position() or !get_global_mouse_position() == Vector2(980,400):
		#print("visible")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_old_pos = get_global_mouse_position()
	elif mouse_old_pos == get_global_mouse_position():
		#print("same pos")
		if get_global_mouse_position() == Vector2(980,400) and !mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	else:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		mouse_old_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("Shoot") and focus and !mouse_on_button:
		mouse = true
		#await  get_tree().create_timer(0.2).timeout
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		focus = false
		$QuitButton.release_focus()
		$SettingsButton.release_focus()
		$HellPlayButton.release_focus()
		$HeavenPlayButton.release_focus()

#Quit
func _on_quit_button_pressed() -> void:
	if pressed: return
	pressed = true
	SoundPlayer.play_sfx_2(SoundPlayer.accept)
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()
func _on_quit_button_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
	$QuitButton.grab_focus()
	focus = true
	mouse_on_button = true
func _on_quit_button_mouse_exited() -> void:
	$QuitButton.texture_focused = quit_normal_outline
	$QuitButton.release_focus()
	focus = false
func _on_quit_button_button_up() -> void:
	$QuitButton.texture_focused = quit_normal_outline
func _on_quit_button_button_down() -> void:
	$QuitButton.texture_focused = quit_pressed_outline

#Settings
func _on_settings_button_pressed() -> void:
	if pressed: return
	#pressed = true
	SoundPlayer.play_sfx_2(SoundPlayer.accept)
	print("Settings to do")
func _on_settings_button_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
	$SettingsButton.grab_focus()
	focus = true
	mouse_on_button = true
func _on_settings_button_mouse_exited() -> void:
	$SettingsButton.release_focus()
	focus = false
	mouse_on_button = false
func _on_settings_button_button_up() -> void:
	$SettingsButton.texture_focused = settings_normal_outline
func _on_settings_button_button_down() -> void:
	$SettingsButton.texture_focused = settings_pressed_outline

#Hell
func _on_hell_play_button_pressed() -> void:
	if pressed: return
	pressed = true
	Global.world = false
	SoundPlayer.play_sfx_2(SoundPlayer.accept_long)
	print("Played from hell pressed")
	SceneTransition.change_scene("res://Hell/hell_main.tscn", "PixelHell")
	#get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
func _on_hell_play_button_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
	$HellPlayButton.z_index = 1
	$HellPlayButton.grab_focus()
	focus = true
	mouse_on_button = true
func _on_hell_play_button_mouse_exited() -> void:
	$HellPlayButton.z_index = 0
	$HellPlayButton.release_focus()
	focus = false
	mouse_on_button = false
func _on_hell_play_button_button_up() -> void:
	$HellPlayButton.texture_focused = hell_normal_outline
func _on_hell_play_button_button_down() -> void:
	$HellPlayButton.texture_focused = hell_pressed_outline
func _on_hell_play_button_focus_entered() -> void:
	$HellPlayButton.z_index = 1
func _on_hell_play_button_focus_exited() -> void:
	$HellPlayButton.z_index = 0

#Heaven
func _on_heaven_play_button_pressed() -> void:
	if pressed: return
	pressed = true
	Global.world = true
	SoundPlayer.play_sfx_2(SoundPlayer.accept_long)
	print("Played from heaven pressed")
	SceneTransition.change_scene("res://Heaven/heaven_main.tscn", "PixelHeaven")
	#get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
func _on_heaven_play_button_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
	$HeavenPlayButton.z_index = 1
	$HeavenPlayButton.grab_focus()
	focus = true
	mouse_on_button = true
func _on_heaven_play_button_mouse_exited() -> void:
	$HeavenPlayButton.z_index = 0
	$HeavenPlayButton.release_focus()
	focus = false
	mouse_on_button = false
func _on_heaven_play_button_button_up() -> void:
	$HeavenPlayButton.texture_focused = heaven_normal_outline
func _on_heaven_play_button_button_down() -> void:
	$HeavenPlayButton.texture_focused = heaven_pressed_outline
func _on_heaven_play_button_focus_entered() -> void:
	$HeavenPlayButton.z_index = 1
func _on_heaven_play_button_focus_exited() -> void:
	$HeavenPlayButton.z_index = 0


func _on_music_start_timer_timeout() -> void:
	SoundPlayer.play_menu_music()

func _on_title_wave_timer_timeout() -> void:
	wave_animation()

func wave_animation() -> void:
	var letters: = get_node("Title")
	for i in letters.get_child_count():
		var sprite: = letters.get_child(i)
		var tween: = create_tween()
		var delay: = i * 0.15
		tween.tween_property(sprite, "position:y", sprite.position.y - 15, 0.25).set_trans(Tween.TRANS_SINE).set_delay(delay)
		tween.tween_property(sprite, "position:y", sprite.position.y, 0.40).set_trans(Tween.TRANS_SINE)
