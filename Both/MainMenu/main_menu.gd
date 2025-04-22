extends Control

func _ready() -> void:
	$VBoxContainer/HeavenButton.grab_focus()
	$MusicStartTimer.start()

func _on_heaven_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Heaven/heaven_main.tscn")
	
func _on_hell_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_music_start_timer_timeout() -> void:
	SoundPlayer.play_menu_music()
