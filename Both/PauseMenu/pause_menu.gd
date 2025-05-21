extends Control

var pause_available: bool = true
var focus: bool = true
var pressed: bool = true

var hell_pause_bg: = preload("res://Both/PauseMenu/HellPauseBG.png")
var heaven_pause_bg: = preload("res://Both/PauseMenu/HeavenPauseBG.png")
var resume_outline: = preload("res://Both/PauseMenu/PResumeOutline.png")
var resume_pressed_outline: = preload("res://Both/PauseMenu/PResumePressedOutline.png")
var settings_outline: = preload("res://Both/PauseMenu/PSettingsOutline.png")
var settings_pressed_outline: = preload("res://Both/PauseMenu/PSettingsPressedOutline.png")
var main_menu_outline: = preload("res://Both/PauseMenu/PMainMenuOutline.png")
var main_menu_pressed_outline: = preload("res://Both/PauseMenu/PMainMenuPressedOutline.png")

func _ready() -> void:
	hide()
	#$AnimationPlayer.play("RESET")

func _process(delta: float) -> void:
	escape()
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		SoundPlayer.play_sfx_1(SoundPlayer.select)
		if !focus:
			$Resume.grab_focus()
			focus = true
		focus = true

func _change_background() -> void:
	if Global.world:
		$PauseBackground.texture = heaven_pause_bg
	else:
		$PauseBackground.texture = hell_pause_bg
		

func resume() -> void:
	if !pause_available: return
	#pause_available = false
	if Global.world:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play_backwards("Blur")
	await get_tree().create_timer(0.3).timeout
	get_tree().paused = false
	hide()
	pressed = false
	pause_available = true
	
func pause() -> void:
	if !pause_available: return
	pause_available = false
	pressed = false
	_change_background()
	Global.save_data()
	if Global.world:
		Global.save_heaven_data()
	show()
	$Resume.grab_focus()
	get_tree().paused = true
	if Global.world:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("Blur")
	await get_tree().create_timer(0.3).timeout
	pause_available = true
	

func escape() -> void:
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	if pressed: return
	pressed = true
	SoundPlayer.play_sfx_2(SoundPlayer.accept)
	resume()

func _on_settings_pressed() -> void:
	if pressed: return
	#pressed = true
	SoundPlayer.play_sfx_2(SoundPlayer.accept)
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	if pressed: return
	pressed = true
	#get_tree().paused = false
	$AnimationPlayer.play_backwards("Fade")
	SoundPlayer.background_music_player.stop()
	SoundPlayer.stop_all_sound()
	SoundPlayer.play_sfx_2(SoundPlayer.return_sound)
	print("Played from pause main menu pressed")
	if Global.world:
		SceneTransition.change_scene("res://Both/MainMenu/main_menu.tscn", "PixelBlack")
	else:
		SceneTransition.change_scene("res://Both/MainMenu/main_menu.tscn", "PixelBlack")
	

func _on_resume_button_down() -> void:
	$Resume.texture_focused = resume_pressed_outline
	#button_pressed = true
func _on_resume_button_up() -> void:
	$Resume.texture_focused = resume_outline
	#button_pressed = false

func _on_settings_button_down() -> void:
	$Settings.texture_focused = settings_pressed_outline
func _on_settings_button_up() -> void:
	$Settings.texture_focused = settings_outline

func _on_main_menu_button_down() -> void:
	$MainMenu.texture_focused = main_menu_pressed_outline
func _on_main_menu_button_up() -> void:
	$MainMenu.texture_focused = main_menu_outline


func _on_resume_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
func _on_resume_mouse_exited() -> void:
	$Resume.texture_focused = resume_outline
	$Resume.release_focus()
	focus = false

func _on_settings_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
func _on_settings_mouse_exited() -> void:
	$Settings.texture_focused = settings_outline
	$Settings.release_focus()
	focus = false

func _on_main_menu_mouse_entered() -> void:
	if pressed: return
	SoundPlayer.play_sfx_1(SoundPlayer.select)
func _on_main_menu_mouse_exited() -> void:
	$MainMenu.texture_focused = main_menu_outline
	$MainMenu.release_focus()
	focus = false
