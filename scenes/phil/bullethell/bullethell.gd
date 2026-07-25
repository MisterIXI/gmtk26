extends Node2D

@export var bullet_scn: PackedScene = null

@onready var player: CharacterBody2D = $player
@onready var spawn_position: PathFollow2D = $Path2D/SpawnPosition
@onready var bullet_timer: Timer = $BulletTimer
var bullet: Bullet = null


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)



func _on_bullet_timer_timeout() -> void:
	var bullet: Bullet = bullet_scn.instantiate()
	add_child(bullet)
	bullet.position = spawn_position.position
	bullet.spawn_pos = bullet.position
	bullet.target_pos = player.position
	spawn_position.progress_ratio = randf_range(0.0, 1.0)
