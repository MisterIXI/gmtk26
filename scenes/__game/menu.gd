extends Node2D

@export var setting_node : Node2D
@export var credits_node :Node2D

@export var click_sound : AudioStreamPlayer
@export var error_sound : AudioStreamPlayer

@export var party_particle : CPUParticles2D
@export var gmtk_fact_label : Label

@export var golden_paw_spawner : Node2D
@export var paw_logo : Node2D

@export var questionmark_label :Label

var master_index
var music_index
var sfx_index

#### button function
var _version_county : int  =0
var _question_mark_county : int = 0
var _golden_paw_score : int = 2
################### START
func _ready() -> void:
	master_index = AudioServer.get_bus_index("Master")
	music_index = AudioServer.get_bus_index("Music")
	sfx_index = AudioServer.get_bus_index("SFX")

func add_score() ->void:
	_golden_paw_score += 1
	if questionmark_label:
		questionmark_label.text  = str(_golden_paw_score) + " Paws"

############### SLIDERS SETTINGS #
func _on_h_slider_music_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(music_index, linear_to_db(_value / 100))

func _on_h_slider_audio_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(master_index, linear_to_db(_value / 100))
	print("area hitted")
func _on_h_slider_sound_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(_value / 100))

func _on_start_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:

	if _event.is_pressed():
		if click_sound:
			click_sound.play()

		print("start game")
	

func _on_setting_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()
		setting_node.visible  = !setting_node.visible
		if credits_node.visible and setting_node.visible:
			credits_node.visible = false


func _on_credits_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()

		credits_node.visible = !credits_node.visible

		if setting_node.visible and credits_node.visible:
			setting_node.visible  = false


func _on_quit_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()
		get_tree().quit()


func _on_version_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()
		_version_county += 1
		if _version_county  >= 10:
			#partyparticle on position
			if party_particle:
				party_particle.emitting = true
			_version_county = 0


func _on_backrooms_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if error_sound:
			error_sound.play()
		#later director mode - select favorite game
		
#gmtk_fact_label

func _on_gmtk_fact_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()
	#random infos about all gmtks
	
		var _random_array : Array[String] = ["Gmtk was created by British journalist Mark Brown begging in 2014",
		"The first GMTK game jam in 2017 with 2.857 Creators and 731 Games",
		"Game Maker`s Toolkit hosted 10 Game Jams",
		"The first GMTK Theme was :Downwell`s Dual Purpose Design"]
		if gmtk_fact_label:
			
			gmtk_fact_label.text = _random_array.pick_random()
		#e.g. First GmTK was 2015 on a rainy friday


func _on_questionmark_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if click_sound:
			click_sound.play()
		_question_mark_county += 1
		if _question_mark_county >= 100:
			if golden_paw_spawner:
				golden_paw_spawner.start_spawning()
	


func _on_logo_button_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event.is_pressed():
		if paw_logo:
			paw_logo.scale = Vector2.ONE
			var _logo_tween = create_tween()
			_logo_tween.tween_property(paw_logo,"scale", Vector2.ONE *1.25, 0.08).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			_logo_tween.tween_property(paw_logo, "scale", Vector2.ONE, 0.12).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
