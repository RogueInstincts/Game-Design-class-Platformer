extends CharacterBody2D

@onready var sprite = $enemy_sprite
@onready var direction = -1
@onready var enemy = $"."
@onready var hitbox = $hitbox
@onready var player = $"../player"
@onready var platformer = $".."

const SPEED = 200.0
const JUMP_VELOCITY = -530.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func kill():
	queue_free()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall():
		direction *= -1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true
	
	if hitbox.has_overlapping_bodies():
		Global.gold += 1
		queue_free()
	
	move_and_slide()
