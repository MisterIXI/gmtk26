extends Node2D


@export_range(0.0, 3.0, 0.1) var max_diff: float = 1.0

@onready var hue_slider: HSlider = $HueSlider
@onready var sat_slider: HSlider = $SatSlider
@onready var value_slider: HSlider = $ValueSlider
@onready var cham_sprite: Sprite2D = $ChameleonColor
@onready var chameleon_outline: Sprite2D = $ChameleonOutline
@onready var background: ColorRect = $Background

@onready var cheer_sfx: AudioStreamPlayer = $cheerSFX
@onready var boo_sfx: AudioStreamPlayer = $booSFX


var sat_gradient = preload("uid://ckrbqokqv2d57")
var value_gradient = preload("uid://rtunpq1ig5xk")
var chameleon_text = preload("uid://dp3mibbj8fy8l")
const CHAMELEON_OUTLINE_HAPPY = preload("uid://rlu83gdxy8g")
const CHAMELEON_OUTLINE_SAD = preload("uid://dlhegwciy07ma")






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
	Countdown.ended.connect(check_color)


func update_color() -> void:
	cham_sprite.modulate = Color.from_hsv(cham_hue, cham_sat, cham_value)
	sat_gradient.gradient.set_color(1, Color.from_hsv(cham_hue, 1, 1))
	value_gradient.gradient.set_color(1, Color.from_hsv(cham_hue, 1, 1))


func random_color() -> void:
	background.modulate = Color(randf_range(0.0,1.0), randf_range(0.0,1.0),randf_range(0.0,1.0))
	var bg_col = background.modulate
	chameleon_text.font_color = Color(1-bg_col.r, 1-bg_col.g, 1-bg_col.b, 1)


func check_color() -> void:
	var cham_color: Color = cham_sprite.modulate 
	var bg_color: Color = background.modulate
	var diff: float = abs(cham_color.r - bg_color.r) + abs(cham_color.g - bg_color.g) + abs(cham_color.b - bg_color.b)
	print(diff, cham_color, bg_color)
	if diff > max_diff:
		boo_sfx.play()
		chameleon_outline.texture = CHAMELEON_OUTLINE_SAD
		await get_tree().create_timer(1.5).timeout
		lose.emit()
	else:
		cheer_sfx.play()
		chameleon_outline.texture = CHAMELEON_OUTLINE_HAPPY
		await get_tree().create_timer(1.5).timeout
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
	
