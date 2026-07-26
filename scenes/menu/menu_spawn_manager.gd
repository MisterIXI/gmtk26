extends Node2D

const GOLDEN_PAW_SCENE  = preload("res://scenes/menu/golden_paw.tscn")
const INTERVAL : float = 0.5
const MAX_SPAWNING_GOLDEN_PAWS : int = 10000

var _is_running: bool = false

var _county : int =  0
var _interval_current_time :float = 0.0

func start_spawning()->void:
	_is_running = true

func _physics_process(_delta: float) -> void:
	if _is_running:
		_spawn_golden_paws()

	
func _spawn_golden_paws() ->void:
	if _county >= MAX_SPAWNING_GOLDEN_PAWS:
		_is_running = false
		return
	_county +=1

	var _new_instance = GOLDEN_PAW_SCENE.instantiate()
	add_child(_new_instance)
	_new_instance.position = Vector2(randf_range(0, 1280), randf_range(0,720))
