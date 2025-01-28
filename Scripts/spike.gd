extends Sprite2D
#var heaven_gui: = get_tree().root.get_node("/root/HeavenGuid")
#heaven_gui: = get_tree().root.get_node("./HeavenGUI")
var gui: Node = null
func _ready() -> void:
	gui = get_tree().get_root().find_child("HeavenGUI", true, false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.player_health -= 1
	gui.update_health_icon()
	#heaven_gui.update_health_icon()
	#heaven_gui.update_health_icon()
	#get_tree().reload_current_scene()
