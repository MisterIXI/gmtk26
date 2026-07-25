extends Node2D

@export var bullet_scn: PackedScene = null

@onready var player: Area2D = $player
@onready var spawn_position: PathFollow2D = $Path2D/SpawnPosition
@onready var bullet_timer: Timer = $BulletTimer

signal win
signal lose

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Countdown.start(5)
	Countdown.ended.connect(win.emit)



func _on_bullet_timer_timeout() -> void:
	var bullet: Bullet = bullet_scn.instantiate()
	add_child(bullet)
	spawn_position.progress_ratio = randf_range(0.0, 1.0)
	bullet.position = spawn_position.position
	bullet.spawn_pos = bullet.position
	bullet.target_pos = player.position
	bullet.look_at(bullet.target_pos)


func _on_player_body_entered(_body: Node2D) -> void:
	lose.emit()


func _on_child_exiting_tree(_node: Node) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
