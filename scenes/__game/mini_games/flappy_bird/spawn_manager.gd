extends Node2D

const PIPE_SCENE = preload("res://scenes/__game/mini_games/flappy_bird/pipe.tscn")


@export var max_random_spawn_range : float = 200.0
@export var interval : float = 3.5
@onready var timer : Timer = $Timer

var spawning_max_queue : int = 20
var offset :float = 720.0 /2.0
var viewport_rect 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = interval
	viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
############## MAIN MECHANIC ##############
func _on_timer_timeout() ->void:

	_spawn_pipe()
##########################################

func _spawn_pipe() ->void:
	#instantiate new pipe delete old  from puffer
	var _new_instance = PIPE_SCENE.instantiate() as Flappy_Bird_Pipe
	#add child
	add_child(_new_instance)
	#set position x to end of camera
	_new_instance.position.x = viewport_rect.end.x + 300
	#set random Y position in range of 720/2
	var half_height : float  = viewport_rect.size.y /2
	_new_instance.position.y = randf_range(viewport_rect.size.y *0.15 -half_height,viewport_rect.size.y * 0.65-half_height)
	_new_instance.position.y += offset


	
	