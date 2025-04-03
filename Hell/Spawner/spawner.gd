extends Node

@onready
var rng: = RandomNumberGenerator.new()
@onready
var flying_head: = preload("res://Enemies/FlyingHead/flying_head.tscn")
@onready
var temple: = preload("res://Enemies/Temple/temple.tscn")
@onready
var enemie_spawn: Array[int] = [1,5,9,15,20,24,30]

var gui: Node = null
var wave_ongoing: bool = false

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	spawn_enemies()
		
func spawn_enemies() -> void:
	wave_ongoing = true
	gui.update_wave_label()
	for i in enemie_spawn[Global.current_wave]:
		await get_tree().create_timer(0.3).timeout
		var fh: = flying_head.instantiate()
		var spawn_length: = %Spawns.get_child_count()-1
		var rand_num: = rng.randi_range(0,spawn_length)
		var spawn_position: Vector2 = %Spawns.get_child(rand_num).position
		fh.position = spawn_position
		%Enemies.add_child(fh)
		
	wave_ongoing = false

func _on_enemy_killed() -> void:
	await get_tree().create_timer(0.1).timeout
	print(str( %Enemies.get_child_count()))
	if %Enemies.get_child_count() == 0 and !wave_ongoing:
		next_wave()

func next_wave() -> void:
	Global.current_wave += 1
	await get_tree().create_timer(3.0).timeout
	spawn_enemies()


func _on_enemies_child_exiting_tree(node: Node) -> void:
	_on_enemy_killed()
