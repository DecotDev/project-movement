extends Node2D

#Connections
@onready
var interaction_label: = %InteractionLabel
var angel_player: Node

const base_text: = "[E] to "

var active_areas: Array[Area2D]
var can_interact: bool = true

func _ready() -> void:
	angel_player = get_tree().get_root().find_child("Lumber", true, false)
	
func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		interaction_label.text = base_text + active_areas[0].action_name
		interaction_label.global_position = active_areas[0].global_position
		interaction_label.position.y -= 120
		interaction_label.global_position.x -= interaction_label.size.x / 2
		interaction_label.visible = true
	else:
		interaction_label.visible = false
	if Global.angel_player_bloqued:
		interaction_label.visible = false
	#else: interaction_label.visible = true
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("E-Key") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			interaction_label.visible = false
			
			await active_areas[0].interact.call()
			
			can_interact = true

func _sort_by_distance_to_player(area1: Area2D, area2: Area2D) -> float:
	var area1_to_angel_player: float = angel_player.global_position.distance_to(area1.global_position)
	var area2_to_angel_player: float = angel_player.global_position.distance_to(area1.global_position)
	return area1_to_angel_player < area2_to_angel_player

func register_area(area: InteractionArea) -> void:
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea) -> void:
	var index: int = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index) 
