extends Node2D


@export var henry: PathFollow2D
@export var dog_scene: PackedScene
@export var lanes: Array[Path2D]
var dogs: Array[PathFollow2D] = []
@export var dog_speed:float = 0.3
var henry_lane: int = 1

signal win
signal lose


func _ready() -> void:
	# Engine.time_scale = 1.3
	spawn_on_lane(lanes[1])
	# spawn_random()
	Countdown.start(7)
	Countdown.ended.connect(win.emit)

func _physics_process(delta: float) -> void:
	for dog in dogs:
		dog.progress_ratio = min(dog.progress_ratio + delta * dog_speed, 1.0)
		if dog.progress_ratio >= 1.0:
			dog.queue_free()
	dogs = dogs.filter(func(item): return not item.is_queued_for_deletion())

func spawn_random() -> void:
	spawn_on_lane(lanes.pick_random())
	# spawn_on_lane(lanes[1])

func spawn_two_random() -> void:
	var lane1 = lanes.pick_random()
	var lane2 = lanes.pick_random()
	while lane1 == lane2:
		lane2 = lanes.pick_random()
	spawn_on_lane(lane1)
	spawn_on_lane(lane2)

func spawn_on_lane(path: Path2D) -> void:
	var new_dog: PathFollow2D = dog_scene.instantiate()
	dogs.append(new_dog)
	path.add_child(new_dog)
	print("Spawned dog on ", path.name)
	new_dog.progress_ratio = 0

func _on_timer_timeout() -> void:
	# spawn_random()
	spawn_two_random()

func update_henry_lane() -> void:
	henry.get_parent().remove_child(henry)
	lanes[henry_lane].add_child(henry)
	henry.progress_ratio = 0.7

func _on_button_left_pressed() -> void:
	henry_lane = max(henry_lane - 1, 0)
	update_henry_lane()

func _on_button_right_pressed() -> void:
	henry_lane = min(henry_lane + 1, 2)
	update_henry_lane()


func _on_henry_area_entered(_area: Area2D) -> void:
	if _area.is_in_group("dog"):
		lose.emit()
		henry.modulate = Color.RED
