extends Node2D


@export var buttons : Array[Button]
@export var label : Label
@export var dict : Dictionary[String, Color]


var declared = false

signal win
signal lose


func _ready() -> void:
	Countdown.start(4)
	Countdown.ended.connect(lose.emit)

	var keys = dict.keys()
	keys.shuffle()
	buttons.shuffle()
	for button in buttons:
		if keys:
			var txt = keys.front()
			keys.erase(keys.front())
			var clr = dict[txt]

			if not declared:
				button.pressed.connect(win.emit)
				label.modulate = clr
				label.text = txt
				declared = true
			else:
				button.pressed.connect(lose.emit)

			button.self_modulate = clr