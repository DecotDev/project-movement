extends Control
var playing: bool = false
var music_position: float

func _on_button_pressed() -> void:
	if !SoundPlayer.background_music_player.playing:
		playing = true
		#SoundPlayer.play_sound(SoundPlayer.pick_coin)
		#SoundPlayer.play_music(SoundPlayer.pick_coin)
		SoundPlayer.play_music(null, music_position)
	elif SoundPlayer.background_music_player.playing:
		playing = false
		music_position = SoundPlayer.background_music_player.get_playback_position()
		SoundPlayer.background_music_player.stop()


func _on_prevoius_pressed() -> void:
	SoundPlayer.play_previous_song()


func _on_next_pressed() -> void:
	SoundPlayer.play_next_song()
