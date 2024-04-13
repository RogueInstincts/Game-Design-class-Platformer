extends StaticBody2D

@onready var hitbox = $hitbox
@onready var platformer = $".."
@onready var tile_map = $"../TileMap"
@onready var up1 = $"."
@onready var image = $image

var can_add = 1
var cooldown = 0

func add_life():
	if can_add > 0 and cooldown == 0:
		platformer.lives += 1
		var heart = load("res://heart.tscn")
		heart = heart.instantiate()
		heart.transform.origin = transform.origin + Vector2(0,-20)
		platformer.add_child(heart)
		can_add -= 1
		cooldown = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hitbox.has_overlapping_bodies() and can_add > 0:
		add_life()
	if can_add == 0:
		image.texture = load("res://dirt.png")
	if cooldown > 0:
		cooldown -= 1
