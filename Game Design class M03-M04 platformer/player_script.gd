extends CharacterBody2D

@onready var sprite = $player_sprite
@onready var hitbox = $hitbox
@onready var tilemap = $"../TileMap"
@onready var label = $"../view/points"
@onready var player = $"."
@onready var platformer = $".."
@onready var view = $"../view"
@onready var item = $item_held

@onready var fedora = false
@onready var dragon = false
@onready var shield = false
@onready var shield_time = 0

const SPEED = 250.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func powerup_fedora():
	apply_scale(Vector2(1, 2))
	sprite.texture = load("res://character_tall.png")
	sprite.apply_scale(Vector2(1, 0.56))
	if shield:
		item.apply_scale(Vector2(1, 0.5))
	fedora = true

func powerup_dragon():
	if not fedora:
		powerup_fedora()
	sprite.texture = load("res://character_dragon.png")
	dragon = true

func powerup_shield():
	item.texture = load("res://shield.png")
	if fedora:
		item.apply_scale(Vector2(1, 0.5))
	shield_time = 10
	shield = true

func powerup_lose():
	apply_scale(Vector2(1, 0.5))
	sprite.texture = load("res://character.png")
	sprite.apply_scale(Vector2(1, (1/0.56)))
	var roll = load("res://roll_away.tscn")
	roll = roll.instantiate()
	roll.transform.origin = transform.origin
	platformer.add_child(roll)
	fedora = false
	dragon = false

func kill():
	Global.lives -= 1
	queue_free()
	
	if Global.lives > 0:
		player = load("res://player.tscn")
		player = player.instantiate()
		platformer.add_child(player)
		platformer.player = player
		view.reset()
	else:
		platformer.get_tree().change_scene_to_file("res://dead.tscn")

func _physics_process(delta):
	if shield_time > 0:
		shield_time -= 1 * delta
	else:
		shield = false
		item.texture = null
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true
	
	if hitbox.has_overlapping_bodies():
		if shield:
			var objects = hitbox.get_overlapping_bodies()
			for i in objects:
				i.kill()
				Global.gold += 1
		elif fedora:
			var objects = hitbox.get_overlapping_bodies()
			for i in objects:
				i.kill()
			powerup_lose()
		else:
			kill()
	
	
	
	if dragon and Input.is_action_just_pressed("Attack"):
		var fireball = load("res://fireball.tscn")
		fireball = fireball.instantiate()
		fireball.transform.origin = transform.origin
		platformer.add_child(fireball)
	
	move_and_slide()
