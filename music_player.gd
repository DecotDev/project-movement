extends Control
var playing: bool = false
var music_position: float

@onready
var playing_label: = %PlayingLabel

func _on_button_pressed() -> void:
	if !SoundPlayer.background_music_player.playing:
		playing = true
		#SoundPlayer.play_sound(SoundPlayer.pick_coin)
		#SoundPlayer.play_music(SoundPlayer.pick_coin)
		SoundPlayer.play_music(null, music_position)
		update_playing_label()
	elif SoundPlayer.background_music_player.playing:
		playing = false
		music_position = SoundPlayer.background_music_player.get_playback_position()
		SoundPlayer.background_music_player.stop()


func _on_prevoius_pressed() -> void:
	SoundPlayer.play_previous_song()
	update_playing_label()


func _on_next_pressed() -> void:
	SoundPlayer.play_next_song()
	update_playing_label()

func update_playing_label() -> void:
	await get_tree().create_timer(0.1).timeout
	playing_label.text = (str(SoundPlayer.hell_music_info[SoundPlayer.actual_song_num]))
