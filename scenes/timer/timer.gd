extends Node2D

@export var numbers : Array[Sprite2D]

var _relative_time

func _process(_delta: float) -> void:
	if not Countdown.running:
		return
	

	_relative_time = (Countdown.remaining_time / Countdown.max_time) * 6
	show_number(numbers[ceil(_relative_time)-1])


func show_number(num : Sprite2D):
	for number in numbers:
		if number != num:
			number.visible = false
	num.visible = true
