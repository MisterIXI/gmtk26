extends Label

@export var animation_duration : float = 0.5
@export var audio : AudioStreamPlayer


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()


func _on_visibility_changed() -> void:
	if visible:
		audio.play()
		modulate.a = 0
		var tween = create_tween()
		# tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "modulate:a", 1, animation_duration)
		audio.play()

		await tween.finished
		tween.kill()
		tween = create_tween()
		# tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(self, "modulate:a", 0, animation_duration)
		await tween.finished
		_on_visibility_changed()
