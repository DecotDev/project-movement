extends Control

@onready
var flame_bar: = %TextureProgressBar
@onready
var reloading_label: = %ReloadingLabel

func _ready() -> void:
	flame_bar.max_value = 8
	flame_bar.value = 8
	#%TextureProgressBar.value = 2

func update_ammo_label(ammo: int, magazine_size: int) -> void:
	%AmmoLeftLabel.text = (str(ammo) + "/" + str(magazine_size))
	update_flame_bar(ammo)

func update_flame_bar(ammo: int) -> void:
	%TextureProgressBar.value = ammo
	#flame_bar.value = ammo

func enable_reloading() -> void:
	reloading_label.visible = true
	
func disable_reloading() -> void:
	reloading_label.visible = false
