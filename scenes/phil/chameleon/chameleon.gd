extends Node2D


@export_range(0.0, 3.0, 0.1) var max_diff: float = 1.0

@onready var hue_slider: HSlider = $HueSlider
@onready var sat_slider: HSlider = $SatSlider
@onready var value_slider: HSlider = $ValueSlider
@onready var cham_sprite: Sprite2D = $ChameleonColor
@onready var background: Sprite2D = $Background


var cham_hue: float = 0.25
var cham_sat: float = 0.8
var cham_value: float = 0.5

signal win
signal lose


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hue_slider.set_value_no_signal(cham_hue)
	sat_slider.set_value_no_signal(cham_sat)
	value_slider.set_value_no_signal(cham_value)
	update_color()
	random_color()
	Countdown.start(10)
	Countdown.ended.connect(check_color.bind(cham_sprite.modulate, background.modulate))


func update_color() -> void:
	cham_sprite.modulate = Color.from_hsv(cham_hue, cham_sat, cham_value)


func random_color() -> void:
	background.modulate = Color(randf_range(0.0,1.0), randf_range(0.0,1.0),randf_range(0.0,1.0))


func check_color(cham_color: Color, bg_color: Color) -> void:
	var diff_color: Color = cham_color - bg_color
	var diff: float = abs(diff_color.r) + abs(diff_color.g) + abs(diff_color.b)
	print(diff_color)
	if diff > max_diff:
		lose.emit()
	else:
		win.emit()



func _on_hue_slider_value_changed(value: float) -> void:
	cham_hue = value
	update_color()


func _on_sat_slider_value_changed(value: float) -> void:
	cham_sat = value
	update_color()


func _on_value_slider_value_changed(value: float) -> void:
	cham_value = value
	update_color()
