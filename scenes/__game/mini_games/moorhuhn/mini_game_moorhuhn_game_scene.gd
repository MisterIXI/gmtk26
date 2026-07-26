extends Node2D
class_name Moorhuhn_Manager

var is_shooting : bool = false

@onready var hud : Control = $Hud

signal win
signal lose

func _ready() -> void:
	Countdown.start(10)
	Countdown.ended.connect(lose.emit)

func shooting() ->void:
	is_shooting = true
	#create timer 0.3s

	await get_tree().create_timer(0.3).timeout
	is_shooting = false


func get_shooting() ->bool:
	if is_shooting:
		# Count up or win
		hud.count_up_score()
		if hud.current_score > 5:
			game_won()
		return true
	else:
		return false

func game_won() ->void:
	win.emit()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE