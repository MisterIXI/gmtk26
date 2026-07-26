extends CanvasLayer

@onready var button_restart : Button = $Button_Control/VBoxContainer/Button_Restart
@onready var button_menu : Button  =$Button_Control/VBoxContainer/Button_Menu
@onready var button_quit : Button  = $Button_Control/VBoxContainer/Button_Quit

func _ready() -> void:
	button_restart.pressed.connect(_on_button_restart)
	button_menu.pressed.connect(_on_button_menu)
	button_quit.pressed.connect(_on_button_quit)

func _on_button_restart() ->void:
	print("button restart pressed")

func _on_button_menu() ->void:
	print("button menu pressed")

func _on_button_quit() ->void:
	print("button quit pressed")
	get_tree().quit()
