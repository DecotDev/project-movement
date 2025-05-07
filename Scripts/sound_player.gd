extends Node

var rng: = RandomNumberGenerator.new()

var music_player: Node = null

#Heaven
const pick_coin: = preload("res://Assets/Sounds/Coin/coin0.wav")
const bep1: = preload("res://Both/TextBox/SFX/Bep1.wav")
const bep2: = preload("res://Both/TextBox/SFX/Bep2.wav")
const bep3: = preload("res://Both/TextBox/SFX/Bep3.wav")

	#Songs
const journey_day: = preload("res://Both/StartJourneyDay.mp3")

#Hell
const supressed_shot: = preload("res://Assets/Guns/SupressedShot.wav")
const mag_and_rag: = preload("res://Assets/Guns/MagAndRack.mp3")
const dry_fire: = preload("res://Assets/Guns/DryFire.mp3")
const gun_mode_click: = preload("res://DemonPlayer/gun_mode_click.mp3")
const gun_hit: = preload("res://DemonPlayer/gun_hit.wav")

const hurt_short: = preload("res://Both/SFX/HurtShort.wav")
const hurt_mid: = preload("res://Both/SFX/HurtMid.wav")

const small_orb_pickup: = preload("res://Currency/HellOrbs/Small/small_orb_pickup.wav")
const big_orb_pickup: = preload("res://Currency/HellOrbs/Big/big_orb_pickup.wav")

	#Enemies
const flying_head_death: = preload("res://Enemies/FlyingHead/flying_head_death.wav")
const temple_destroyed: = preload("res://Enemies/Temple/temple_destroyed.wav")

const projectile_fly: = preload("res://Enemies/Projectiles/projectile_fly.wav")

	#Songs
const hellfire_symphony: AudioStream = preload("res://Assets/HellMusic/HellfireSymphony.mp3")
const hellfire_chill_symphony: AudioStream = preload("res://Assets/HellMusic/HellfireChillSymphony.mp3")
const demon_dancefloor: = preload("res://Assets/HellMusic/DemonDancefloor.mp3")
const pixelated_inferno: = preload("res://Assets/HellMusic/PixelatedInferno.mp3")
const front_incursion: = preload("res://Assets/HellMusic/Front_Incursion.wav")

#Connections
@onready
var sfx_1: = $SFX1
@onready
var background_music_player: = %BackgroundMusicPlayer
@onready
var audio_players: = $AudioPlayers
@onready
var menu_music_player: = $MenuMusicPlayer

var actual_song_num: int
var previous_song_num: int

var hell_music: Array[AudioStream] = [pick_coin, hellfire_symphony, hellfire_chill_symphony, demon_dancefloor, pixelated_inferno, front_incursion]
var hell_music_info: Array[String] = ["Coin - Pitch", "Hellfire Symphony", "Hellfire Chill","Demon dancefloor", "Pixelated Inferno", "Front Incursion"]

func _ready() -> void:
	music_player = get_tree().get_root().find_child("MusicPlayer", true, false)

func play_sound(sound: AudioStream) -> void:
	for audioStreamPlayer in audio_players.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.volume_db = Global.sound_effects_db
			if sound == supressed_shot:
				audioStreamPlayer.volume_db = Global.shoot_db + Global.sound_effects_db
			elif sound == flying_head_death:
				audioStreamPlayer.volume_db = Global.flying_head_death + Global.sound_effects_db
			audioStreamPlayer.play()
			break

func play_2d_sound(sound: AudioStream) -> void:
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()
			
func play_sfx_1(sound: AudioStream) -> void:
	sfx_1.stream = sound
	sfx_1.volume_db = Global.sound_effects_db
	sfx_1.play()

func play_music(music: AudioStream, music_position: float) -> void:
	if actual_song_num == 0:
		actual_song_num = rng.randi_range(1, hell_music.size()-1)
		while actual_song_num == previous_song_num:
			actual_song_num = rng.randi_range(1, hell_music.size()-1)
	var actual_song: AudioStream = hell_music[actual_song_num]
	background_music_player.stream = actual_song
	background_music_player.play(music_position)

func play_menu_music() -> void:
	if !menu_music_player.playing:
		menu_music_player.volume_db = Global.meun_music_db
		menu_music_player.stream = journey_day
		menu_music_player.play()
	

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
	music_player.update_playing_label()


func _on_menu_music_payer_finished() -> void:
	play_menu_music()
