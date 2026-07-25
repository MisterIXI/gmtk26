extends Node2D

@export_group("Buttons")
@export var win_button :  Button
@export var lose_button : Button

signal win
signal lose
# signal pause_timer

func _ready() -> void:
	win_button.pressed.connect(win.emit)
	lose_button.pressed.connect(lose.emit)

func _process(_delta: float) -> void:
	if not visible:
		return
