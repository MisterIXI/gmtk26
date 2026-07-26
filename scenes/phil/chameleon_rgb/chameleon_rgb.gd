extends Node2D


@export_range(0.0, 3.0, 0.1) var max_diff: float = 1.0

@onready var r_slider: HSlider = $RSlider
@onready var g_slider: HSlider = $GSlider
@onready var b_slider: HSlider = $BSlider
@onready var cham_sprite: Sprite2D = $ChameleonColor
@onready var chameleon_outline: Sprite2D = $ChameleonOutline
@onready var background: ColorRect = $Background

@onready var cheer_sfx: AudioStreamPlayer = $cheerSFX
@onready var boo_sfx: AudioStreamPlayer = $booSFX

var chameleon_text = preload("uid://dp3mibbj8fy8l")
const CHAMELEON_OUTLINE_HAPPY = preload("uid://rlu83gdxy8g")
const CHAMELEON_OUTLINE_SAD = preload("uid://dlhegwciy07ma")



var cham_r: float = 0.3
var cham_g: float = 0.5
var cham_b: float = 0.1

signal win
signal lose


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	r_slider.set_value_no_signal(cham_r)
	g_slider.set_value_no_signal(cham_g)
	b_slider.set_value_no_signal(cham_b)
	update_color()
	random_color()
	Countdown.start(10)
	Countdown.ended.connect(check_color)


func update_color() -> void:
	cham_sprite.modulate = Color(cham_r, cham_g, cham_b, 1.0)


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
		await boo_sfx.finished
		lose.emit()
	else:
		cheer_sfx.play()
		chameleon_outline.texture = CHAMELEON_OUTLINE_HAPPY
		await cheer_sfx.finished
		win.emit()



func _on_hue_slider_value_changed(value: float) -> void:
	cham_r = value
	update_color()


func _on_sat_slider_value_changed(value: float) -> void:
	cham_g = value
	update_color()


func _on_value_slider_value_changed(value: float) -> void:
	cham_b = value
	update_color()
