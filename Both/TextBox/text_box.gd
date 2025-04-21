extends MarginContainer

@onready
var label: = %TextLabel
@onready
var timer: = %LetterDisplayTimer
@onready
var next_mark: = $NinePatchRect/Control/NextMark


const MAX_WIDTH: int = 560 #512 #256

var text: String = ""
var letter_index: int = 0

var letter_time: float = 0.03
var space_time: float = 0.06
var punctuation_time: float = 0.2

signal finished_displaying()

func _ready() -> void:
	scale = Vector2.ZERO

func display_text(text_to_display: String) -> void:
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await  resized # wait for x resize
		await  resized # wait for y resize
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 54
	
	label.text = ""
	
	pivot_offset = Vector2(size.x / 2, size.y)
	
	var tween: = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 0.30).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	_display_letter()
	
func _display_letter() -> void:
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		next_mark.visible = true
		return
		
	match text[letter_index]:
		"!", ",", ".", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

			SoundPlayer.play_sfx_1(SoundPlayer.bep2)

func _hide_text_box() -> void:
	var tween1 := get_tree().create_tween()
	tween1.tween_property(self, "scale", Vector2(0, 0), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tween1.finished
	queue_free()

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
