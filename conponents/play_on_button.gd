extends AudioStreamPlayer
class_name PlayOnButton

@export var button : Button


func _ready() -> void:
	button.pressed.connect(_play_audio)


func _play_audio():
	playing = true