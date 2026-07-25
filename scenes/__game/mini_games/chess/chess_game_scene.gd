extends Node2D

@export var nodes : Array[Node]


signal win
signal lose

func _ready() -> void:
	for node in nodes:
		for child in node.get_children():
			child.win_game.connect(win.emit)
			child.lose_game.connect(lose.emit)
	Countdown.start(10)
	Countdown.ended.connect(lose.emit)
