extends Control

@onready
var flame_bar: = %TextureProgressBar
@onready
var reloading_label: = %ReloadingLabel
@onready
var health_label: = %HealthLabel
@onready
var enemies_label: = %EnemiesLabel
@onready
var wave_label: = %WaveLabel

func _ready() -> void:
	flame_bar.max_value = 12
	flame_bar.value = 12
	health_label.text = ("Health: " + str(Global.demon_health))
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
	
func update_health_label() -> void:
	health_label.text = ("Health: " + str(Global.demon_health))
	
func update_enemies_label() -> void:
	enemies_label.text = ("Enemeies killed: " + str(Global.killed_enemies))
	
func update_wave_label() -> void:
	wave_label.text = ("Wave " + str(Global.current_wave))
