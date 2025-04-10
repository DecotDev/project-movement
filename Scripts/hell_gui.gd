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
@onready
var dash_cooldown_bar: = %DashCooldownBar
@onready
var health_flask: = %HealthFlask
@onready
var animation_player: = %AnimationPlayer

var wave_text_duration: int = 6

func _ready() -> void:
	flame_bar.max_value = 12
	flame_bar.value = 12
	update_health_label()
	#%TextureProgressBar.value = 2
	wave_label.text = ("")

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
	var demon_health: = Global.demon_health 
	if demon_health > 5:
		animation_player.play("6_beat")
	elif demon_health > 4:
		animation_player.play("5_beat")
	elif demon_health > 3:
		animation_player.play("4_beat")
	elif demon_health > 2:
		animation_player.play("3_beat")
	elif demon_health > 1:
		animation_player.play("2_beat")
	elif demon_health > 0:
		animation_player.play("1_beat")
	
func update_enemies_label() -> void:
	enemies_label.text = ("Enemeies killed: " + str(Global.killed_enemies))
	
func update_wave_label() -> void:
	wave_label.text = ("WAVE " + str(Global.current_wave))
	wave_label.visible = true
	await get_tree().create_timer(wave_text_duration).timeout
	
	wave_label.visible = false
	
func update_dash_cooldown_bar(progress: float) -> void:
	dash_cooldown_bar.value = 100 - progress
	
func update_hell_orbs_label() -> void:
	%HellOrbsLabel.text = ("" + str(Global.hell_orbs))
