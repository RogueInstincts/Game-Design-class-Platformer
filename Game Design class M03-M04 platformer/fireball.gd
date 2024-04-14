extends CharacterBody2D

@onready var platformer = $".."
@onready var hitbox = $hitbox
@onready var sprite = $sprite

@onready var direction = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	if platformer.player.sprite.flip_h:
		direction = -1
	elif not platformer.player.sprite.flip_h:
		direction = 1

func _physics_process(delta):
	if is_on_wall():
		queue_free()
	
	# Get the direction and handle the movement/deceleration.
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
		i.kill()
		Global.gold += 1
		queue_free()
	
	move_and_slide()
