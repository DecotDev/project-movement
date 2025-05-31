extends Node2D

func _ready() -> void:
	InteractionManager.clear_active_areas()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	SoundPlayer.menu_music_player.stop()
	SoundPlayer.background_music_player.stop()
	Global.world = true
	#Global.angel_player_bloqued = false
	#Global.demon_player_bloqued = false
	Global.load_heaven_data()
	InteractionManager.load_players_node()
