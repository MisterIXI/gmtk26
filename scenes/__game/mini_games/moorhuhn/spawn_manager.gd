extends Node2D

const CHICKEN_WING_SCENE : PackedScene = preload("res://scenes/__game/mini_games/moorhuhn/chicken_wing.tscn")
@export var interval : float = 0.5

var _interval_current_time :float = 0.0
var _mother : Node2D
func _ready() -> void:
	_mother = get_parent()
	await _mother.ready
	# _spawn_at(Vector2(randi_range(0,200), randi_range(50,720)))
	_spawn_at(Vector2(randi_range(0,200), randi_range(50,720)))
	# _spawn_at(Vector2(randi_range(100,300), randi_range(50,720)))
	_spawn_at(Vector2(randi_range(200,400), randi_range(50,720)))
	# _spawn_at(Vector2(randi_range(300,500), randi_range(50,720)))
	_spawn_at(Vector2(randi_range(400,700), randi_range(50,720)))
	# _spawn_at(Vector2(randi_range(500,800), randi_range(50,720)))

func _process(delta: float) -> void:
	#spawn new chicken after time 0.5 s
	_interval_current_time += delta
	if _interval_current_time >= interval:
		_interval_current_time = 0.0
		_spawn()

func _spawn() ->void:
	_spawn_at(Vector2( -100, randi_range(50,720)))

func _spawn_at(pos: Vector2):
	var _new_instance = CHICKEN_WING_SCENE.instantiate()
	_mother.add_child(_new_instance)
	_new_instance.global_position = pos
