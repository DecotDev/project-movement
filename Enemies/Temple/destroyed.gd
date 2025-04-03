extends TempleState

func enter(previous_state_path: String, data := {}) -> void:
	print("e- Destroy")
	state_label.text = "Destroy"
	temple.queue_free()
