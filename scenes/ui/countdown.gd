extends Node2D

const FRAME_SIZE: float =128.0

@onready var sprite : Sprite2D  =$Sprite2D
@onready var audio_stream_player :AudioStreamPlayer =$AudioStreamPlayer

var accumulator : float = 0.0


func _ready() -> void:
	sprite.region_enabled = true


func _process(_delta: float) -> void:
	#calculate elapsed time
	var elapsed : float = Countdown.max_time - Countdown.remaining_time
	# print("Elapsed: %s; Max: %s; Remaining: %s" % [elapsed, Countdown.max_time, Countdown.remaining_time])
	#calculate scroll pixels
	var scroll_pixel : float  = elapsed * FRAME_SIZE
	# change offset
	scroll_pixel = clamp(scroll_pixel, 0.0, FRAME_SIZE * 9.0)

	# mask
	sprite.region_rect = Rect2(
		0.0,
		scroll_pixel,
		128.0,
		128.0
	)

	if not Countdown.running:
		return

	update_sound(_delta)


func update_sound(_delta : float) ->void:
	var _interval : float  = lerp(0.08, 1.0, Countdown.remaining_time / Countdown.max_time)

	# add accumulator for interval
	accumulator +=  _delta
	if accumulator >= _interval:
		accumulator = 0.0
		#Play Sound
		if audio_stream_player:
			audio_stream_player.play()
