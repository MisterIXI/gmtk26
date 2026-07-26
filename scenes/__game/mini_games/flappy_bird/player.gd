extends CharacterBody2D
class_name Flappy_Bird_Player

@export var jump_power :float = 350
@export var jump_rotation : float  = -10

@onready var particles : CPUParticles2D = $CPUParticles2D
#dead particle 
@onready var dying_particles: CPUParticles2D = $Dying_Particle

@onready var anim_sprite : AnimatedSprite2D =$AnimatedSprite2D
#sound
@onready var hit_sound : AudioStreamPlayer = $Hit_Sound
@onready var jump_sound : AudioStreamPlayer = $Jump_Sound

var gravity: Vector2 = Vector2(0, ProjectSettings.get(&"physics/2d/default_gravity"))
var max_speed : float = 400.0
var score:  int = 0
var is_active : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		_jump()
	
	#apply gravity
	velocity += gravity * delta
	#cap max velocity y
	velocity.y = min(velocity.y , max_speed)
	#rotate body to ground
	rotation = rotate_toward(rotation, -60, delta)
	#move body move
	move_and_slide()


func _jump() ->void:
	if !is_active:
		return
	# sound
	jump_sound.play()
	#particles
	if particles:
		particles.emitting = true
		particles.emitting = false
	#jump power added to velocity
	velocity.y =-jump_power
	#rotate up
	rotation = deg_to_rad(jump_rotation)

#############################################
func on_death() ->void:
	if !is_active :
		return
	hit_sound.play()
	is_active = false
	anim_sprite.play("dying")
	#Signal death
	print("flappy bird lose")
	if dying_particles:
		dying_particles.emitting = true


	######## SIGNAL TO MOTHER LOSE CONDITION
	if get_parent():
		get_parent().on_game_lose()

#############################################
func on_score() ->void:
	score +=1
	if score >= 3:
		#win signal 
		print("win")
