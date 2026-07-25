extends Node2D

@export var henry: PackedScene
@export var larry: PackedScene
@export var kelly: PackedScene


func _ready() -> void:
	var henry_inst = henry.instantiate()
	add_child(henry_inst)
	var bounds = get_viewport().size
	henry_inst.position = Vector2(randi_range(0, bounds.x), randi_range(0, bounds.y))
