extends Node2D
@export var color_rect : ColorRect
@export var lose_label : Label
@export var win_label : Label
signal win
signal lose

var allready_done: bool = false
func _ready() -> void:
	Countdown.start(9)
	Countdown.ended.connect(_on_game_win)

func _on_game_win() ->void:
	
	if win_label and !allready_done:
		allready_done = true
		win_label.visible =true
	win.emit()

func on_game_lose() ->void:

	if color_rect:
		flash(0.5)
	lose.emit()

func flash(duration: float = 0.5) -> void:
	var tween = create_tween()
    # Fade alpha from 1 (fully visible) to 0 (hidden) quickly
	color_rect.modulate.a = 1.0
	if lose_label and !allready_done:
		allready_done = true
		lose_label.visible = true

	tween.tween_property(color_rect, "modulate:a", 0.0, duration)