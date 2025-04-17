extends CharacterBody2D

#Connections
@onready
var animation_player: = %AnimationPlayer
@onready
var interaction_area: = %InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	print("Hi")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var current_time: float = animation_player.current_animation_position
		animation_player.play("IdleNear")
		animation_player.seek(current_time, true)
		
		#var idle_length: float = animation_player.get_animation("Idle").length
		#var idel_near_length: float = animation_player.get_animation("IdleNear").length
		#var current_time: float = animation_player.current_animation_position
		#var time_ratio: = current_time / idle_length
		#animation_player.play("IdleNear")
		#animation_player.seek(time_ratio * idel_near_length, true)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		var current_time: float = animation_player.current_animation_position
		animation_player.play("Idle")
		animation_player.seek(current_time, true)
