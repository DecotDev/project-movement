extends Node

var rng: = RandomNumberGenerator.new()

const pick_coin: = preload("res://Assets/Sounds/Coin/coin0.wav") 
const supressed_shot: = preload("res://Assets/Guns/SupressedShot.wav")
const mag_and_rag: = preload("res://Assets/Guns/MagAndRack.mp3")
const dry_fire: = preload("res://Assets/Guns/DryFire.mp3")

const hellfire_symphony: AudioStream = preload("res://Assets/HellMusic/HellfireSymphony.mp3")
const hellfire_chill_symphony: AudioStream = preload("res://Assets/HellMusic/HellfireChillSymphony.mp3")
const demon_dancefloor: = preload("res://Assets/HellMusic/DemonDancefloor.mp3")
const pixelated_inferno: = preload("res://Assets/HellMusic/PixelatedInferno.mp3")

@onready
var background_music_player: = %BackgroundMusicPlayer
@onready
var audioPlayers: = $AudioPlayers

var actual_song_num: int

var previous_song_num: int

var hell_music: Array[AudioStream] = [pick_coin, hellfire_symphony, hellfire_chill_symphony, demon_dancefloor, pixelated_inferno]

#func _ready() -> void:
	#hell_music.append(hellfire_chill_symphony)

func play_sound(sound: AudioStream) -> void:
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
			
func play_music(music: AudioStream, music_position: float) -> void:
	if actual_song_num == 0:
		actual_song_num = rng.randi_range(1, hell_music.size()-1)
		while actual_song_num == previous_song_num:
			actual_song_num = rng.randi_range(1, hell_music.size()-1)
	var actual_song: AudioStream = hell_music[actual_song_num]
	background_music_player.stream = actual_song
	background_music_player.play(music_position)

func resume_music() -> void:
	var actual_song: AudioStream = hell_music[actual_song_num]
	background_music_player.stream = actual_song
	
func play_next_song() -> void:
	previous_song_num = actual_song_num
	actual_song_num = 0
	play_music(null, 0)
	
func play_previous_song() -> void:
	var music_position: float = background_music_player.get_playback_position()
	if music_position > 3:
		play_music(null, 0)
	elif music_position < 3:
		actual_song_num = previous_song_num
		play_music(null, 0)

func _on_background_music_player_finished() -> void:
	previous_song_num = actual_song_num
	actual_song_num = 0
	play_music(null, 0)
