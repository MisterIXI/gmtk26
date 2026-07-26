extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_deadzone_area_body_entered)

func _on_deadzone_area_body_entered(body: Node2D) -> void:
	if body and body is Flappy_Bird_Player:
		print("dead by deadzone")
		body.on_death()