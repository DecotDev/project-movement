extends Area2D
class_name InteractionArea

@export
var action_name: String = "interact"

var interact: Callable = func () -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer: return
	if body is Demon or Player:
		#print(str(body.name) + " entered an area")
		InteractionManager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Demon or Player:
		#print(str(body.name) + " exited an area")
		InteractionManager.unregister_area(self)
	
