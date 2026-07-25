extends Area2D

@export var moving_icon :Node2D
@export var moving_piece :Node2D

@export var piece_collected : Node2D = null
@export var win : bool = false

@export var _win_label : Label
@export var _lose_label : Label

var is_active : bool = false
var _move_pieces_sound : AudioStreamPlayer


signal win_game
signal lose_game


func _ready() -> void:
	_move_pieces_sound = get_tree().get_first_node_in_group("move_pieces_sound")

	moving_icon.visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed()->void:
	is_active = moving_icon.visible


func _on_move_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event is InputEventMouseButton and _event.is_pressed():
		if is_active:
			moving_icon.visible  =false
			if piece_collected:
				var _tween_collecting = create_tween()
				#scale to 0
				_tween_collecting.tween_property(piece_collected, "scale", Vector2(0,0),0.5)
				#kill
				_tween_collecting.tween_callback(piece_collected.queue_free)

			
			moving_piece.global_position = global_position
			#sound 
			if _move_pieces_sound:
				_move_pieces_sound.play()
			
			moving_piece.scale = Vector2(1,1)
			moving_piece.offset.y =0
			#
			# animation
			#tween winning piece becomes bigger and win appears
			var _tween = create_tween()
			_tween.tween_property(moving_piece, "scale", Vector2(50,50),5)
			#Result
			if win:
				_win_label.show()
				win_game.emit()

			else:
				_lose_label.show()
				lose_game.emit()
		else:
			print("Piece is not activated")
