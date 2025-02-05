extends Control

@onready
var flame_bar: = %TextureProgressBar

func _ready() -> void:
	flame_bar.max_value = 8

func update_ammo_label(ammo: int, magazine_size: int) -> void:
	%AmmoLeftLabel.text = (str(ammo) + "/" + str(magazine_size))
	update_flame_bar(ammo)

func update_flame_bar(ammo: int) -> void:
	flame_bar.value+1
