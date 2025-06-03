extends Control

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
@onready
var hell_orbs_label: = %HellOrbsLabel
@onready
var wave_animation_player: = %WaveAnimationPlayer

var wave_text_duration: int = 3 #6
var hell_orbs_label_original_position: Vector2


func _ready() -> void:
	hell_orbs_label_original_position = hell_orbs_label.position
	update_health_label()
	update_hell_orbs_label()
	#%TextureProgressBar.value = 2
	wave_label.text = ("")
	%AnimationPlayer.play("RESET")

func update_ammo_label(ammo: int, magazine_size: int) -> void:
	%AmmoLeftLabel.text = (str(ammo) + "/" + str(magazine_size))
	

func enable_reloading() -> void:
	reloading_label.visible = true
	reloading_label.modulate.a = 1.0
	
func disable_reloading() -> void:
	
	var reload_tween: = get_tree().create_tween()
	#reloading_label.scale = Vector2(1.8,1.8)
	reload_tween.tween_property(reloading_label, "modulate:a", 0.0, 0.3)
	await reload_tween.finished
	print("Reload twin finished")
	#.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
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
	elif demon_health < 1:
		animation_player.play("0_left")
func update_enemies_label() -> void:
	enemies_label.text = ("Enemeies killed: " + str(Global.killed_enemies))
	
func update_wave_label() -> void:
	wave_label.text = "" 
	wave_label.text = ("WAVE " + str(Global.current_wave))
	wave_animation_player.play("Burn_IN")
	SoundPlayer.play_sound(SoundPlayer.guitar_dark_fade)
	#wave_label.visible = true
	await get_tree().create_timer(wave_text_duration).timeout
	
	wave_animation_player.play("Burn_OUT")
	
	
func update_dash_cooldown_bar(progress: float) -> void:
	dash_cooldown_bar.value = 100 - progress
	
func update_hell_orbs_label() -> void:
	%HellOrbsLabel.text = (str(Global.hell_orbs))
	var orb_tween: = get_tree().create_tween()
	hell_orbs_label.scale = Vector2(1.8,1.8)
	orb_tween.tween_property(hell_orbs_label, "scale", Vector2(1,1), 0.26).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var orb_pos_tween: = get_tree().create_tween()
	hell_orbs_label.position = hell_orbs_label.position - Vector2(8,18)
	orb_pos_tween.tween_property(hell_orbs_label, "position", hell_orbs_label_original_position, 0.26).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func update_fire_mode_label(full_auto: bool) -> void:
	if full_auto:
		%FireModeLabel.text = ("Full auto")
	else:
		%FireModeLabel.text = ("Semi")
