extends Node

var world: bool

var max_emeralds: int = 7
var player_emeralds: int

@onready
var heaven_doors: Array[Node] = []
#@onready var heaven_doors2: Array[Node] = get_node("/root/").get_children()


var angel_player_bloqued: bool = false
var demon_player_bloqued: bool = false
var hell_respawn: = false
var player_health: int = 3
var player_coins: int = 0
var demon_health: int = 6
var magazine_size: int = 12
var ammo: int = 12
var hell_orbs: int = 0



var current_wave: int = 1

var sound_effects_db: float = -2.4
var shoot_db: float = -7.0
var flying_head_death: float = -2.0
var meun_music_db: = -12

var max_wave: = 100

var gui_focus: bool = false
var elevator_block: bool = true
var on_safe_zone: bool = true

#To save and load

	#To implement
var max_reached_wave: int
var total_waves_played: int
var killed_enemies: int = 0
var total_orbs_collected: int
var total_coins_collected: int

	#heaven_doors = get_tree().get_root().find_child("HeavenDoors", true, false).get_children()
	#await get_tree().create_timer(1.0).timeout
	#var hd_node: = get_tree().get_root().find_child("HeavenDoors", true, false)
	#if hd_node:
		#heaven_doors = hd_node.get_children()
	#else:
		#print("Warning: HeavenDoors node not found in the scene tree!")

func save_data() -> void:
	var existing_data := {}
	if FileAccess.file_exists("user://save.json"):
		var file := FileAccess.open("user://save.json", FileAccess.READ)
		existing_data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(existing_data) != TYPE_DICTIONARY:
			existing_data = {}
	
	var save_dictionary: Dictionary = {
		"player_coins": player_coins,
		"hell_orbs": hell_orbs,
		"player_emeralds": player_emeralds,
		"max_reached_wave": max_reached_wave,
		"total_waves_played": total_waves_played,
		"killed_enemies": killed_enemies,		
	}
	var file:  = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_dictionary))
	file.close()
	
func save_heaven_data() -> void:
	var existing_data := {}
	if FileAccess.file_exists("user://heaven_save.json"):
		var file := FileAccess.open("user://heaven_save.json", FileAccess.READ)
		existing_data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(existing_data) != TYPE_DICTIONARY:
			existing_data = {}
	
	
	if world:
		heaven_doors = get_tree().get_root().find_child("HeavenDoors", true, false).get_children()
	var save_dictionary: Dictionary = {
		"heaven_doors": existing_data.get("heaven_doors", {})
	}
	print("Saving, heaven_doors.size: " + str(heaven_doors.size()))
	for door in heaven_doors:
		print("Heaven Door id: " + str(door.id) + " Closed: " + str(door.closed))
		save_dictionary["heaven_doors"][door.id] = door.closed
	var file:  = FileAccess.open("user://heaven_save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_dictionary))
	file.close()
	
func save_hell_data() -> void:
	pass

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
			if data.has("player_emeralds"):
				player_emeralds = data["player_emeralds"]
			if data.has("killed_enemies"):
				killed_enemies = data["killed_enemies"]

func load_heaven_data() -> void:
	heaven_doors = get_tree().get_root().find_child("HeavenDoors", true, false).get_children()
	if FileAccess.file_exists("user://heaven_save.json"):
		var file := FileAccess.open("user://Heaven_save.json", FileAccess.READ)
		var json := file.get_as_text()
		file.close()

		var data: Dictionary = JSON.parse_string(json)
		if typeof(data) == TYPE_DICTIONARY and data.has("heaven_doors"):
			var heaven_doors_data: Dictionary = data["heaven_doors"]
			for door in heaven_doors:
				var key := str(door.id)
				if heaven_doors_data.has(key):
					door.closed = heaven_doors_data[key]
					print("Loaded door " + key + ": " + str(door.closed))
					door.apply_export_var()

func load_hell_data() -> void:
	pass
