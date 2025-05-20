extends Node

#wave timer 2s

var rng: = RandomNumberGenerator.new()

@onready
var flying_head: PackedScene = preload("res://Enemies/FlyingHead/flying_head.tscn")
@onready
var temple: PackedScene = preload("res://Enemies/Temple/temple.tscn")
@onready
var enemy_spawn: Array[int] = [1]
#var enemy_spawn: Array[int] = [1,	1,	5,	9,	15,	20,	24,	30, 1]
@onready
var enemies: Array[PackedScene] = [preload("res://Enemies/FlyingHead/flying_head.tscn"), preload("res://Enemies/Temple/temple.tscn")]


var enemy_types: = 2
#var enemy_types: Array[int] =  [2,2]#[1,	2,	2,	2,	2,	2,	2]

var gui: Node = null
var bullet_shells: Node = null
var wave_ongoing: bool = false


func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_PAUSABLE
	generate_enemies()
	#await get_tree().create_timer(6.0, false).timeout
	gui = get_tree().get_root().find_child("HellGUI", true, false)
	bullet_shells = get_tree().get_root().find_child("BulletShells", true, false)
	#spawn_enemies()

func generate_enemies() -> void:
	var num: int = 0
	var waves: int = Global.max_wave
	var start_enemy_count: int = 1
	enemy_spawn[num] = start_enemy_count
	while num < waves:
		if num < enemy_spawn.size():
			enemy_spawn[num] += 3
		else:
			enemy_spawn.append(enemy_spawn[num-1] + 3) 
		num += 1
	print(str(enemy_spawn))

func spawn_enemies() -> void:
	var enemy: PackedScene
	wave_ongoing = true
	gui.update_wave_label()
	for i in enemy_spawn[Global.current_wave-1]:
		if i % 3 == 0:
			enemy = enemies[0]
		else:
			enemy = enemies[rng.randi_range(0, enemy_types-1)]
		await get_tree().create_timer(1.2, false).timeout
		var enemy_node: Node = enemy.instantiate()
		var spawn_length: = %Spawns.get_child_count()-1
		var rand_num: = rng.randi_range(0,spawn_length)
		var spawn_position: Vector2 = %Spawns.get_child(rand_num).position
		enemy_node.position = spawn_position
		%Enemies.add_child(enemy_node)
		
	wave_ongoing = false
		
func spawn_enemies_old() -> void:
	wave_ongoing = true
	gui.update_wave_label()
	for i in enemy_spawn[Global.current_wave]:
		await get_tree().create_timer(0.3, false).timeout
		var fh: Node = flying_head.instantiate()
		var spawn_length: = %Spawns.get_child_count()-1
		var rand_num: = rng.randi_range(0,spawn_length)
		var spawn_position: Vector2 = %Spawns.get_child(rand_num).position
		fh.position = spawn_position
		%Enemies.add_child(fh)
	wave_ongoing = false

func _on_enemy_killed() -> void:
	await get_tree().create_timer(0.1, false).timeout
	#print(str( %Enemies.get_child_count()))
	if %Enemies.get_child_count() == 0 and !wave_ongoing:
		next_wave()

func next_wave() -> void:
	Global.current_wave += 1
	print("Wave: " + str(Global.current_wave))
	print("Enemies: " + str(enemy_spawn[Global.current_wave]))
	await get_tree().create_timer(3.0, false).timeout
	for child in bullet_shells.get_children():
		child.queue_free()
	spawn_enemies()


func _on_enemies_child_exiting_tree(node: Node) -> void:
	_on_enemy_killed()


func _on_orbs_child_exiting_tree(node: Node) -> void:
	gui.update_hell_orbs_label()




func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.name == "HellTileMapLayer": return
	print("Seafe are entered: " + str(body.name))


func _on_safe_area_body_exited(body: Node2D) -> void:
	if body.name == "HellTileMapLayer": return
	print("Seafe are exited: " + str(body.name))
	await get_tree().create_timer(0.5, false).timeout
	spawn_enemies()
