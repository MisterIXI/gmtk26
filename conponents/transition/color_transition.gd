extends ColorRect
class_name ColorTransition
@export var animation_duration : float = 0.4

signal half
signal full

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	if visible:
		modulate.a = 0
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "modulate:a", 1, animation_duration)

		await tween.finished
		half.emit()
		tween.kill()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(self, "modulate:a", 0, animation_duration)
		await tween.finished
		hide()

		full.emit()