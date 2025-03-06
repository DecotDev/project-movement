extends Node

const pick_coin: = preload("res://Assets/Sounds/Coin/coin0.wav") 
const supressed_shot: = preload("res://Assets/Guns/SupressedShot.wav")

@onready
var audioPlayers: = $AudioPlayers

func play_sound(sound: AudioStream) -> void:
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
