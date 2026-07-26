extends CharacterBody2D

@export var jump_power :float = 350
@export var jump_rotation : float  = 10

@onready var particles : CPUParticles2D = $CPUParticles2D

var gravity: Vector2 = Vector2(0, ProjectSettings.get(&"physics/2d/default_gravity"))
var is_jumping : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_jumping:
		
		velocity.y =-jump_power
		rotation = deg_to_rad(jump_rotation)
		
	if !is_jumping:#rotate ti Vector2.Down
		rotation = rotate_toward(rotation, -90, delta)
		#apply gravity
		velocity += gravity * delta
		#move body move
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		is_jumping = false
	if event.is_action_pressed("jump"):
		is_jumping =true
		if particles:
			particles.emitting = true
