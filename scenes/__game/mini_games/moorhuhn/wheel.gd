extends Sprite2D
@export var speed :float = 1.0


func _process(delta: float) -> void:
    rotation += speed * delta