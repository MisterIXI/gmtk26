extends TextureRect



func _on_gui_input(_event: InputEvent) -> void:
	if _event.is_pressed():
		if get_parent():
			get_parent().add_score()
			queue_free()
