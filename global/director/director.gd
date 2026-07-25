extends Node

@export_group("Games")
@export var games : Array[PackedScene]

@export_group("General")
@export var transition : ColorTransition

var _playlist: Array[PackedScene] = []
var _current_game : Node
var _last_game_name : String = ""


func _enter_tree() -> void:
	for game in games:
		if not game:
			games.erase(game)

	# show overland start animation
	_change_game()
	_start_game()


func _pick_random() -> Node:
	if _playlist.is_empty():
		_playlist = games.duplicate()
		_playlist.shuffle()
		if _playlist.front().resource_name == _last_game_name:
			_playlist.push_back(_playlist.front())

	var game = _playlist.front()
	_last_game_name = game.resource_name
	_playlist.erase(game)

	game = game.instantiate()
	add_child(game)
	return game


func _subscribe_to_signals(game : Node) -> bool:
	if game.has_signal("win"):
		game.win.connect(_win_game.bind(game))
	else:
		print("[Director] WARNING: " + game.name + " missing 'win' signal! Skipping game.")
		return false

	if game.has_signal("lose"):
		game.lose.connect(_lose_game.bind(game))

	if game.has_signal("pause_countdown"):
		game.pause_countdown.connect(_pause_countdown.bind(game))
	return true


func _kill_game():
	Countdown.pause()
	if _current_game:
		_current_game.hide()
		_current_game.queue_free()


func _change_game():
	Countdown.reset()
	_kill_game()

	_current_game = _pick_random()
	if not _subscribe_to_signals(_current_game):
		_change_game()
	_stop_game()


func _stop_game():
	_current_game.process_mode = Node.PROCESS_MODE_DISABLED


func _start_game():
	_current_game.process_mode = Node.PROCESS_MODE_INHERIT
	Countdown.start()


func _win_game(game):
	if game == _current_game:
		transition.show()
		await transition.half
		_change_game()
		# overland +1 and show animation
		await transition.full
		
		_start_game()


func _lose_game(game):
	if game == _current_game:
		transition.show()
		await transition.half
		_kill_game()
		#open lose screen
		await transition.full


func _pause_countdown(game):
	if game == _current_game:
		Countdown.pause()
