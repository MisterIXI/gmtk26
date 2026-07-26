extends Node2D
class_name Mountain

@export var pathfollow : PathFollow2D
@export var lifes : Array[Sprite2D]
@export var levels : Array[ColorRect]
@export var faster : CanvasItem
@export var dying : Node2D
@export var lives_audio : AudioStreamPlayer
@export var move_audio : AudioStreamPlayer

@export var result_level : Label
@export var result_life1 : Label
@export var result_life2 : Label
@export var result_life3 : Label

@export var end_screen : Control

@export var restart : Button
@export var menu : Button
@export var quit : Button


var win_color : Color = Color(0.388, 0.78, 0.302, 1.0)
var lose_color : Color = Color(0.894, 0.231, 0.267, 1.0)

var ratio = 1.0/12
signal ended
signal life_ended

func _ready() -> void:
	restart.pressed.connect(Director.start.bind(self))
	menu.pressed.connect(Director.main_menu)
	quit.pressed.connect(get_tree().quit)

func change_realm(realm : int):
	end_screen.hide()
	for index in range(levels.size()):
		var level = levels[index]
		for child in level.get_children():
			if child is Label:
				child.text = str(realm) + ":" + str(index +1)
				child.modulate = Color(1.0,1.0,1.0,1.0)
				break

	pathfollow.progress = 0


func go_to_level(level : int, realm : int):
	if level == 6 or level == 1 and not realm == 1:
		faster.show()
	result_level.text = str(realm) + ":" + str(level)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(pathfollow, "progress_ratio", ratio * level, 1.4)
	move_audio.play()
	await tween.finished
	faster.hide()
	ended.emit()


func change_level_state(level_number : int, state : bool):
	for child in levels[level_number -1].get_children():
		if child is Label:
			var target_color = lose_color
			if state:
				target_color = win_color
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.set_ease(Tween.EASE_OUT)
			tween.tween_property(child, "modulate", target_color, 1)
			break


func lose_life(life_count:int, realm, level):
	dying.show()
	lives_audio.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(lifes[life_count], "modulate:a", 0, 1)

	await  tween.finished
	if life_count == 0:
		result_life3.text = str(realm) + ":" + str(level-1)
	elif life_count == 1:
		result_life2.text = str(realm) + ":" + str(level-1)
	elif life_count == 2:
		result_life1.text = str(realm) + ":" + str(level-1)
	dying.hide()
	life_ended.emit()
