extends Node2D

signal timer_timeout()
const FRAME_SIZE: float =128.0

@export var countdown_time : float  = 9.0

@onready var sprite : Sprite2D  =$Sprite2D
@onready var timer : Timer = $Timer
@onready var audio_stream_player :AudioStreamPlayer =$AudioStreamPlayer

var last_second: int = 0
var accumulator : float = 0.0
var offset : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#region enabled
	sprite.region_enabled = true
	timer.wait_time =  countdown_time
	offset = 9 - countdown_time
	#Start timer
	timer.start()

func _process(_delta: float) -> void:
	if timer.is_stopped():
		return
	
	#calculate elapsed time
	var elapsed : float = countdown_time + offset - timer.time_left
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

	update_sound(_delta)
	
func update_sound(_delta : float) ->void:

	var _interval : float  = lerp(0.08, 1.0,timer.time_left / countdown_time)

	# add accumulator for interval
	accumulator +=  _delta
	if accumulator >= _interval:
		accumulator = 0.0
		#Play Sound
		if audio_stream_player:
			audio_stream_player.play()

func _on_timer_timeout() ->void:
	timer_timeout.emit()
