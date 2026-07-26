extends Control


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	if visible:
		modulate.a = 0
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "modulate:a", 1, 0.5)