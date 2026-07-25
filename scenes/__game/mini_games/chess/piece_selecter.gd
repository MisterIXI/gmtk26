extends Node2D
@export var sound_move_pieces : AudioStreamPlayer
var current_piece : Node2D = null

func piece_clicked(_node : Node2D) ->void:
	# play sound if source found
	if sound_move_pieces:

		sound_move_pieces.play()
	
	if _node == current_piece:
		_node.activate_piece(false)
		current_piece = null
	else:
		# disable old piece
		if current_piece:
			current_piece.activate_piece(false)
		# set new
		current_piece = _node
		current_piece.activate_piece(true)
