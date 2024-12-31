extends Node

@onready
var audioPlayers: = $AudioPlayers

func play_sound():
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer
		pass
