extends Node2D

@onready
var heaven_gui: = %HeavenGUI

func _ready() -> void:
	InteractionManager.clear_active_areas()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	SoundPlayer.menu_music_player.stop()
	SoundPlayer.background_music_player.stop()
	Global.world = true
	Global.angel_player_bloqued = false
	Global.demon_player_bloqued = false

func _on_portal_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Hell/hell_main.tscn")
