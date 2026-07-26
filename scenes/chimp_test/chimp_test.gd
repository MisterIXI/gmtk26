extends Node2D

@export var buttons : Array[Button]


signal win
signal lose


func _ready() -> void:
	Countdown.start(12)
	Countdown.ended.connect(lose.emit)

	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button))
		button.position = _get_valid_position()

	buttons.front().pressed.connect(_change_btn_color)


func _get_valid_position() -> Vector2:
	var _x = randi_range(100, 1130)
	var _y = randi_range(100, 580)
	return Vector2(_x, _y)


func _on_button_pressed(btn):
	if btn == buttons.front():
		buttons.erase(btn)
		btn.queue_free()
		if not buttons:
			win.emit()
			return
	else:
		lose.emit()




func _change_btn_color():
	for button in buttons:
		var style_box = button.get_theme_stylebox("normal").duplicate() as StyleBoxFlat
		style_box.bg_color = Color(1.0,1.0,1.0,1.0)
		button.add_theme_stylebox_override("normal", style_box)
		button.add_theme_stylebox_override("pressed", style_box)
		button.add_theme_stylebox_override("hover", style_box)
		button.add_theme_stylebox_override("focus", style_box)
