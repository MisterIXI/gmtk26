extends Node

@export_group("Games")
@export var games : Array[PackedScene]

var _playlist: Array[PackedScene] = []
var _current_game : Node
var _last_game_name : String = ""

func _enter_tree() -> void:
	for game in games:
		if not game:
			games.erase(game)

	_change_game()


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

	# if game.has_signal("pause_timer"):
	# 	game.pause_timer.connect(_pause_timer.bind(game))
	return true


func _change_game():
	if _current_game:
		_current_game.hide()
		_current_game.queue_free()

	_current_game = _pick_random()
	if not _subscribe_to_signals(_current_game):
		_change_game()


func _win_game(game):
	if game == _current_game:
		_change_game()


func _lose_game(game):
	if game == _current_game:
		_change_game()
