class_name Bullet
extends StaticBody2D

var spawn_pos: Vector2i = Vector2i(0,0)
var target_pos: Vector2i = Vector2i(0,0)
var speed: int = 600

func _ready() -> void:
	speed = randi_range(speed - 200, speed + 200)



func _physics_process(delta: float) -> void:
	var move_dir: Vector2 = target_pos - spawn_pos
	var move_dir_normalized = move_dir / sqrt(move_dir.x * move_dir.x 
											+ move_dir.y * move_dir.y)
	move_and_collide(move_dir_normalized * speed * delta)
