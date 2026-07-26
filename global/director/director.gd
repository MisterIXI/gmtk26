extends Node

@export var active : bool = false

@export_group("Games")
@export var games : Array[PackedScene]

@export_group("General")
@export var transition : ColorTransition
@export var mountain : Mountain

var _playlist: Array[PackedScene] = []
var _current_game : Node
var _last_game_name : String = ""

var _signal_recieved : bool = false

var _current_level = 1
var _current_realm = 1
var _current_lifes = 3

var _menu


func _enter_tree() -> void:
	if not active:
		queue_free()

	for game in games:
		if not game:
			games.erase(game)
	
func start(menu) -> void:
	_menu = menu
	Countdown.full_reset()
	mountain.change_realm(1)
	_current_level = 1
	_current_lifes = 3
	_playlist.clear()
	for life in mountain.lifes:
		life.modulate.a = 1.0
	_signal_recieved = false
	transition.show()
	await transition.half
	menu.hide()
	mountain.show()
	await transition.full
	mountain.go_to_level(_current_level, _current_realm)
	await mountain.ended
	transition.show()
	await transition.half
	mountain.hide()
	_change_game()


func main_menu() -> void:
	transition.show()
	await transition.half
	mountain.hide()
	_menu.show()


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
	return true


func _kill_game():
	Countdown.pause()
	if _current_game:
		_current_game.hide()
		_current_game.queue_free()


func _change_game():
	_kill_game()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	_current_game = _pick_random()
	if not _subscribe_to_signals(_current_game):
		_change_game()


func _update_level():
	_current_level += 1
	if _current_level >12:
		_current_realm += 1
		mountain.change_realm(_current_realm)
		_current_level = 1
	if _current_level == 1 or _current_level == 6:
			Countdown.increase_speed()
			print("Increasing speed")


func _win_game(game):
	if _signal_recieved:
		return

	if game == _current_game:
		_signal_recieved = true
		transition.show()
		_update_level()
		await transition.half
		_kill_game()
		mountain.show()
		await transition.full
		mountain.go_to_level(_current_level, _current_realm)
		if _current_level != 1:
			mountain.change_level_state(_current_level-1, true)
		await mountain.ended

		transition.show()
		await transition.half
		mountain.hide()
		_change_game()
		_signal_recieved = false


func _lose_game(game):
	if _signal_recieved:
		return

	if game == _current_game:
		_signal_recieved = true
		transition.show()
		_update_level()
		await transition.half
		_kill_game()
		mountain.show()
		await transition.full
		if _current_level != 1:
			mountain.change_level_state(_current_level-1, false)
		_current_lifes -= 1
		mountain.lose_life(_current_lifes, _current_realm, _current_level)
		await mountain.life_ended
		if _current_lifes < 1:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mountain.end_screen.show()
			return
		mountain.go_to_level(_current_level, _current_realm)
		await mountain.ended

		transition.show()
		await transition.half
		mountain.hide()
		_change_game()
		_signal_recieved = false
