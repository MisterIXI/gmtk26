extends Area2D

var mouse_pos: Vector2i
var level_bounds: Vector2i

func _ready() -> void:
	level_bounds = get_viewport().size

func _process(_delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	position.x = max(min(level_bounds.x, mouse_pos.x), 0)
	position.y = max(min(level_bounds.y, mouse_pos.y), 0)
