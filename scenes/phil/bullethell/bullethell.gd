extends Node2D

@export var bullet_scn: PackedScene = null

var game_over: bool = false

@onready var player: Area2D = $player
@onready var spawn_position: PathFollow2D = $Path2D/SpawnPosition
@onready var bullet_timer: Timer = $BulletTimer

@onready var cheer_sfx: AudioStreamPlayer = $cheerSFX
@onready var boo_sfx: AudioStreamPlayer = $booSFX

signal win
signal lose

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Countdown.start(5)
	Countdown.ended.connect(win_game)

func win_game() -> void:
	if !game_over:
		game_over = true
		cheer_sfx.play()
		await cheer_sfx.finished
		win.emit()

func _on_bullet_timer_timeout() -> void:
	var bullet: Bullet = bullet_scn.instantiate()
	add_child(bullet)
	spawn_position.progress_ratio = randf_range(0.0, 1.0)
	bullet.position = spawn_position.position
	bullet.spawn_pos = bullet.position
	bullet.target_pos = player.position
	bullet.look_at(bullet.target_pos)


func _on_player_body_entered(_body: Node2D) -> void:
	if !game_over:
		game_over = true
		boo_sfx.play()
		player.alive = false
		bullet_timer.stop()
		for child in get_children():
			if child.is_class("StaticBody2D"):
				child.speed = 0
		await boo_sfx.finished
		lose.emit()


func _on_child_exiting_tree(_node: Node) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
