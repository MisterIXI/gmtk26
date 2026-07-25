extends Node2D

@export var pathfollow : PathFollow2D
@export var camera : Camera2D

var current_level : int = 0
var level_progress : Array[float] = [0, 0.071, 0.115, 0.163, 0.212, 0.268, 0.322, 0.377, 0.435, 0.497, 0.553, 0.599, 0.6429, 0.6977, 0.7503, 0.7942, 0.8468, 0.9158, 1]

signal moved

func set_level(level : int):
	current_level = level
	var tween