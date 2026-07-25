extends Node2D

@export_group("Buttons")
@export var target_buttons :  Array[Button]

signal win
signal lose

func _ready() -> void:
	for target in target_buttons:
		target.pressed.connect(_target_pressed.bind(target))
	
	Countdown.start(5)
	Countdown.ended.connect(lose.emit)


func _target_pressed(target) -> void:
	target_buttons.erase(target)
	target.queue_free()

	if target_buttons.is_empty():
		win.emit()
