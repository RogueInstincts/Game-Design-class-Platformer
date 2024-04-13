extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var platformer = $"."
@onready var sprite = $sprite
@onready var hitbox = $hitbox

var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func kill():
	queue_free()

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the direction and handle the movement/deceleration.
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
	
	var objects = hitbox.get_overlapping_bodies()
	for i in objects:
		i.powerup_shield()
		queue_free()
	
	move_and_slide()

