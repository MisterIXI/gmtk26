extends Control
class_name Action_Manager


const BULLET_TEXTURE : Texture2D = preload("res://assets/textures/moorhuhn/ui_bullet.png")
const EMPTY_BULLET_TEXTURE : Texture2D = preload("res://assets/textures/moorhuhn/ui_bullet_emtpy.png")
@export var _reload_icon : Sprite2D
@export var _crossair : Sprite2D
@export var _crossair_empty : Sprite2D
# Textures
@onready var bullet_01 : TextureRect = $MarginContainer/PanelContainer/HBoxContainer/Bullet_01
@onready var bullet_02 : TextureRect = $MarginContainer/PanelContainer/HBoxContainer/Bullet_02
# AudioStreamPlayers
@onready var audio_shoot : AudioStreamPlayer  =$Shoot_Sound
@onready var audio_reload : AudioStreamPlayer = $Reload_Sound
#text 
@onready var _label  : Label = $MarginContainer2/PanelContainer/Score_Label
var current_bullets : int = 2
var current_score : int = 0

var is_empty : bool = false
var is_reloading : bool = false
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event: InputEvent) -> void:
	if event.is_pressed() and event is InputEventMouseButton:
		#check if left or right click
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				#shoot
				if is_empty:
					_reload()

				else:
					_shoot()

			MOUSE_BUTTON_RIGHT:
				_reload()

############### SET SCORE 
func count_up_score() ->void:
	current_score +=1
	_label.text = str(current_score) + " / 5"
###############################
func _shoot() ->void:
	current_bullets -= 1

	audio_shoot.play()

	if current_bullets <= 0:
		is_empty = true
		
		if _reload_icon:
			_reload_icon.show()

		if _crossair:
			_crossair.hide()

		if _crossair_empty:
			_crossair_empty.show()


	#texture
	if current_bullets >=1 :
		bullet_01.texture = BULLET_TEXTURE
	else: 
		bullet_01.texture = EMPTY_BULLET_TEXTURE
	
	if current_bullets >= 2:
		bullet_02.texture = BULLET_TEXTURE
	else: 
		bullet_02.texture = EMPTY_BULLET_TEXTURE
	get_parent().shooting()

func _reload() ->void:
	audio_reload.play()
	await get_tree().create_timer(0.2).timeout
	current_bullets = 2
	is_empty = false
	# textures turn on
	bullet_01.texture = BULLET_TEXTURE
	bullet_02.texture = BULLET_TEXTURE
	#county
	if _crossair:
		_crossair.show()

	if _crossair_empty:
		_crossair_empty.hide()

	if _reload_icon:
		_reload_icon.hide()
