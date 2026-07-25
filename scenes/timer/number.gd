extends Sprite2D

var tween : Tween


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)



func _on_visibility_changed():
	if tween:
		tween.kill()

	scale = Vector2.ONE
	tween = create_tween()
	# tween.set_trans(Tween.TRANS_CUBIC)
	# tween.set_ease(Tween.EASE_OUT)
	var duration = Countdown.max_time / 6
	tween.tween_property(self, "scale", Vector2.ZERO, duration)