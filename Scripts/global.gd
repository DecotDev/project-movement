extends Node

var world: bool

var angel_player_bloqued: bool = false
var demon_player_bloqued: bool = false
var player_health: int = 3
var player_coins: int = 0
var demon_health: int = 6
var magazine_size: int = 12
var ammo: int = 12
var hell_orbs: int

var killed_enemies: int = 0

var current_wave: int = 1

var sound_effects_db: float = -2.4
var meun_music_db: = -12

var gui_focus: bool = false


func save_data() -> void:
	var save_dictionary: Dictionary = {
		"player_coins": player_coins,
		"hell_orbs": hell_orbs
	}
	var file:  = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_dictionary))
	file.close()

func load_data() -> void:
	if FileAccess.file_exists("user://save.json"):
		var file: = FileAccess.open("user://save.json", FileAccess.READ)
		var json: = file.get_as_text()
		file.close()

		var data: Dictionary = JSON.parse_string(json)
		if typeof(data) == TYPE_DICTIONARY:
			if data.has("player_coins"):
				player_coins = data["player_coins"]
			if data.has("hell_orbs"):
				hell_orbs = data["hell_orbs"]
