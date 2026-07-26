extends Node

@export_group("Settings")
@export_range(1, 20, 1) var base_time : float = 5
@export_range(1.0, 2.0)  var mult_mult : float = 1.05


var current_mult : float = 1
var max_time : float = base_time
var remaining_time : float = base_time
var running : bool = false

signal ended
signal speed_changed


func start(time) -> void:
	max_time = time / current_mult
	remaining_time = max_time
	running = true


func pause() -> void:
	running = false


func unpause() -> void:
	running = true


func full_reset() -> void:
	current_mult = 1
	Engine.time_scale = current_mult
	speed_changed.emit()


func increase_speed() -> void:
	current_mult = current_mult * mult_mult
	Engine.time_scale = current_mult
	speed_changed.emit()


func decrease_speed() -> void:
	current_mult = current_mult / mult_mult
	Engine.time_scale = current_mult
	speed_changed.emit()


func _process(delta: float) -> void:
	if not running:
		return
	remaining_time -= delta

	if remaining_time < 0:
		ended.emit()
		running = false