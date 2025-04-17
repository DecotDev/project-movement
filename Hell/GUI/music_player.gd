extends Control
var playing: bool = false
var music_position: float
var control: bool = true

@onready
var playing_label: = %PlayingLabel

func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on and control:
		if !SoundPlayer.background_music_player.playing:
			playing = true
			SoundPlayer.play_music(null, music_position)
			update_playing_label()
			control = true
	if !toggled_on:
		if SoundPlayer.background_music_player.playing:
			playing = false
			music_position = SoundPlayer.background_music_player.get_playback_position()
			SoundPlayer.background_music_player.stop()
			control = true

func _on_next_button_pressed() -> void:
	SoundPlayer.play_next_song()
	if $PlayButton.button_pressed == false:
		control = false
		$PlayButton.button_pressed = true
	update_playing_label()

func _on_previous_button_pressed() -> void:
	SoundPlayer.play_previous_song()
	if $PlayButton.button_pressed == false:
		control = false
		$PlayButton.button_pressed = true
	update_playing_label()

func update_playing_label() -> void:
	await get_tree().create_timer(0.1).timeout
	playing_label.text = (str(SoundPlayer.hell_music_info[SoundPlayer.actual_song_num]))

func _on_play_button_mouse_entered() -> void:
	Global.gui_focus = true

func _on_play_button_mouse_exited() -> void:
	Global.gui_focus = false

func _on_next_button_mouse_entered() -> void:
	Global.gui_focus = true

func _on_next_button_mouse_exited() -> void:
	Global.gui_focus = false

func _on_previous_button_mouse_entered() -> void:
	Global.gui_focus = true

func _on_previous_button_mouse_exited() -> void:
	Global.gui_focus = false
