extends Node2D
@export var color_rect : ColorRect
signal win
signal lose

func _ready() -> void:
	Countdown.start(9)
	Countdown.ended.connect(win.emit)

func on_game_lose() ->void:
	if color_rect:
		flash(0.5)
	lose.emit()

func flash(duration: float = 0.5) -> void:
	var tween = create_tween()
    # Fade alpha from 1 (fully visible) to 0 (hidden) quickly
	color_rect.modulate.a = 1.0
	tween.tween_property(color_rect, "modulate:a", 0.0, duration)