extends CharacterBody2D

@onready var player = $"../player"
@onready var platformer = $".."
@onready var area_2d = $Area2D

func reset():
	transform.origin = Vector2(576,324)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player = platformer.player
	if player.transform.origin.x > transform.origin.x and not area_2d.has_overlapping_bodies():
		transform.origin.x = player.transform.origin.x
	
	move_and_slide()
