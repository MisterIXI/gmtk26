extends Sprite2D
@export var speed :float = 3.0


func _process(delta: float) -> void:
    rotation += speed * delta