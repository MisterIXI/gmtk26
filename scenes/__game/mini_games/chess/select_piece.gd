extends Area2D

@export var piece_possible_moves: Sprite2D
@export var piece_highlighted : Sprite2D


func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event is InputEventMouseButton and _event.is_pressed():
		get_parent().piece_clicked(self)

func activate_piece(_bool : bool) ->void:
	piece_possible_moves.visible = _bool
	if _bool:
		piece_highlighted.scale = Vector2(1.1,1.1)
		piece_highlighted.offset.y =-5
	else: 
		piece_highlighted.scale = Vector2(1,1)
		piece_highlighted.offset.y =0


