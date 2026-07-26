extends Area2D

var speed: float = 10.0
var direction_angle: float = 0.0

var _is_targeted: bool = false

signal clicked

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(direction_angle) * speed * delta


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and _is_targeted:
		clicked.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	var bounds: Vector2i = get_viewport().size
	var exit_pos: Vector2i = position
	position = abs(Vector2i(position) - bounds)
	if exit_pos.x > bounds.x:
		position.x -= 100
	if exit_pos.y > bounds.y:
		position.y -= 100


func _on_mouse_entered() -> void:
	_is_targeted = true


func _on_mouse_exited() -> void:
	_is_targeted = false
