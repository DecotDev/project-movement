extends CharacterBody2D

#Connections
@onready
var animation_player: = %AnimationPlayer
@onready
var interaction_area: = %InteractionArea

#Data
const lines_disabled: Array[String] = [
	"Hi, welcome to Heaven!",
	"By the way, I'm Antonio",
	"Bueno, en español mejor", 
	"Que beinvenido, me llamo Antonio y que ¡VIVA FRANCO!"
]
@export_multiline
var lines: Array[String] = [
	"Hi, welcome to Heaven!",
	"By the way, I'm Antonio"
]

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	#print("Hi")
	DialogManager.start_dialog(global_position, lines)
	look_toward_angelplayer()

func look_toward_angelplayer() -> void:
	var bodys: Array[Node2D] = $Area2D.get_overlapping_bodies()
	for body in bodys:
		print(str(body.name))
		if body is Player:
			#print("Body is player")
			if body.global_position.x < global_position.x:
				$Sprite.flip_h = true
				body.sprite.flip_h = false
			else:
				$Sprite.flip_h = false
				body.sprite.flip_h = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var current_time: float = animation_player.current_animation_position
		animation_player.play("IdleNear")
		animation_player.seek(current_time, true)
		if body.global_position.x < global_position.x:
			$Sprite.flip_h = true
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
		$Sprite.flip_h = false
