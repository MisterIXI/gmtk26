extends AudioStreamPlayer
class_name PlayOnParentVisible

@export var parent : Node


func _ready() -> void:
	parent.visibility_changed.connect(_play_audio)


func _play_audio():
	play()