extends Control

var pause_available: bool = true

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

func _change_background() -> void:
	if Global.world:
		$PauseBackground.texture = heaven_pause_bg
	else:
		$PauseBackground.texture = hell_pause_bg
		

func resume() -> void:
	if !pause_available: return
	pause_available = false
	if Global.world:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play_backwards("Blur")
	await get_tree().create_timer(0.3).timeout
	get_tree().paused = false
	hide()
	pause_available = true
	
func pause() -> void:
	if !pause_available: return
	pause_available = false
	_change_background()
	Global.save_data()
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
	resume()

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	SoundPlayer.background_music_player.stop()
	get_tree().change_scene_to_file("res://Both/MainMenu/main_menu.tscn")


func _on_resume_button_down() -> void:
	$Resume.texture_focused = resume_pressed_outline
func _on_resume_button_up() -> void:
	$Resume.texture_focused = resume_outline

func _on_settings_button_down() -> void:
	$Settings.texture_focused = settings_pressed_outline
func _on_settings_button_up() -> void:
	$Settings.texture_focused = settings_outline

func _on_main_menu_button_down() -> void:
	$MainMenu.texture_focused = main_menu_pressed_outline
func _on_main_menu_button_up() -> void:
	$MainMenu.texture_focused = main_menu_outline
