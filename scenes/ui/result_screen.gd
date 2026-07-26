extends Control

@onready var button_restart : Button = $Button_Control/VBoxContainer/Button_Restart
@onready var button_menu : Button  =$Button_Control/VBoxContainer/Button_Menu
@onready var button_quit : Button  = $Button_Control/VBoxContainer/Button_Quit

#click sound
@onready var click_sound : AudioStreamPlayer = $AudioStreamPlayer
func _ready() -> void:
	button_restart.pressed.connect(_on_button_restart)
	button_menu.pressed.connect(_on_button_menu)
	button_quit.pressed.connect(_on_button_quit)

func _on_button_restart() ->void:
	if click_sound:
		click_sound.play()
	print("button restart pressed")

func _on_button_menu() ->void:
	if click_sound:
		click_sound.play()
	print("button menu pressed")

func _on_button_quit() ->void:
	if click_sound:
		click_sound.play()
	print("button quit pressed")
	get_tree().quit()
