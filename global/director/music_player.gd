extends AudioStreamPlayer2D


func _ready() -> void:
	Countdown.speed_changed.connect(on_speed_changed)

func on_speed_changed() -> void:
	pitch_scale = Countdown.current_mult