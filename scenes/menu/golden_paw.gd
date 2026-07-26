extends TextureRect

const MOVE_DISTANCE : float = 2000.0
const MOVE_TIME : float = 60
const ROTATION_AMOUNT : float = TAU 

func _on_gui_input(_event: InputEvent) -> void:
	if _event.is_pressed():
		if get_parent():
			get_parent().get_parent().add_score()
			queue_free()

func _ready() -> void:
	rotate_and_move()

func rotate_and_move() ->void:
	var direction : Vector2 = Vector2.RIGHT.rotated(randf() * TAU)
	var target_position : Vector2 = global_position +direction * MOVE_DISTANCE

	var target_rotation : float  = ROTATION_AMOUNT *(1 if randf() > 0.5 else -1)

	var _tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_IN_OUT)

	_tween.parallel().tween_property(self,"global_position", target_position, MOVE_TIME)
	_tween.parallel().tween_property(self, "rotation",target_rotation, MOVE_TIME)
