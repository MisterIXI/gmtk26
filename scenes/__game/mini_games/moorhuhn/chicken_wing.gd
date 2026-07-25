extends CharacterBody2D

@export var speed : float = 350.0
@export var direction: Vector2 = Vector2(1,-0.05)

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles : CPUParticles2D =$CPUParticles2D

# Called when the node enters the scene tree for the first time.
var _is_disabled : bool = false

func _process(delta: float) -> void:
	if global_position.x >= 10000 and !_is_disabled :
		_is_disabled = true
		print("Chicken Wing removed")
		queue_free()

	velocity = velocity.move_toward(direction * speed,1)
	move_and_slide()
	
func _on_hurtbox_component_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("is pressed")
		if get_parent():
			if get_parent().get_shooting():
				print("roast chicken")
				_roast_chicken_anim()
		
func _roast_chicken_anim() ->void:
	_is_disabled = true
	cpu_particles.emitting = true
	anim_sprite.play("dying")

	var _tween  = create_tween()
	_tween.tween_property(self,"position:y", 1000, 1)
	_tween.set_trans(Tween.TRANS_EXPO)


	await get_tree().create_timer(1.0).timeout

	queue_free()
