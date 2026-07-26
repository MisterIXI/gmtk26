extends Node2D
class_name Flappy_Bird_Pipe
var speed : float = 0
var is_disabled : bool = false
#difficult
func set_speed(new_speed : float) ->void:
	speed = new_speed

#movement
func _physics_process(delta: float) -> void:
	position.x += speed * delta
	if position.x <= -1000 and !is_disabled:
		is_disabled = true

		queue_free()

# damage
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body and body is Flappy_Bird_Player:
		body.on_death()
#score
func _on_score_area_body_entered(body: Node2D) -> void:
	if body and body is Flappy_Bird_Player:
		body.on_score()