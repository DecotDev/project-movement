extends Node2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundPlayer.menu_music_player.stop()
	Global.world = false
	Global.angel_player_bloqued = false
