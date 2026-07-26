extends Node2D

@export var henry: PackedScene
@export var larry: PackedScene
@export var kelly: PackedScene

@export var larry_count: int = 100
@export var kelly_count: int = 100

signal win
signal lose

@onready var bounds = get_viewport().size

func _ready() -> void:
	
	Countdown.start(12)
	Countdown.ended.connect(lose_game)
	
	if larry != null:
		var larry_speed = randf_range(50, 200)
		var larry_dir = randf_range(0, TAU)
		for i in range(larry_count):
			spawn_character(larry, larry_speed, larry_dir)
	
	if kelly != null:
		var kelly_speed = randf_range(50, 200)
		var kelly_dir = randf_range(0, TAU)
		for i in range(kelly_count):
			spawn_character(kelly, kelly_speed, kelly_dir)
	
	if henry != null:
		var henry_speed = randf_range(50, 200)
		var henry_dir = randf_range(0, TAU)
		var henry_inst = spawn_character(henry, henry_speed, henry_dir)
		henry_inst.z_index = 5
		henry_inst.remove_from_group("not_henry")
		henry_inst.clicked.connect(win_game)
	


func spawn_character(character: PackedScene, speed: float, dir_angle: float) -> Node:
	var char_inst = character.instantiate()
	add_child(char_inst)
	char_inst.speed = speed
	char_inst.direction_angle = dir_angle
	char_inst.position = Vector2(randi_range(0, bounds.x), randi_range(0, bounds.y))
	char_inst.z_index = randi_range(6,7)
	char_inst.add_to_group("not_henry")
	return char_inst

func win_game():
	darken_characters()
	await get_tree().create_timer(1).timeout
	win.emit()

func lose_game():
	darken_characters()
	await get_tree().create_timer(1).timeout
	lose.emit()

func darken_characters() -> void:
	for child in get_children():
		if child.is_in_group("not_henry"):
			child.z_index = 2
			child.modulate = Color(0.3,0.3,0.3,1)
