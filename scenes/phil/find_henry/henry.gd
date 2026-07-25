extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 0.2
	position.y += 0.3


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = abs(Vector2i(position) - get_viewport().size)
