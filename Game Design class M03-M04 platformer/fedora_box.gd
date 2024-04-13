extends StaticBody2D

@onready var hitbox = $hitbox
@onready var platformer = $".."

var can_add = 1
var cooldown = 0

func add_item():
	if can_add > 0 and cooldown == 0:
		if not platformer.player.fedora:
			var item = load("res://fedora.tscn")
			item = item.instantiate()
			item.transform.origin = transform.origin + Vector2(0,-40)
			platformer.add_child(item)
			can_add -= 1
			cooldown = 10
		else:
			var item = load("res://egg.tscn")
			item = item.instantiate()
			item.transform.origin = transform.origin + Vector2(0,-40)
			platformer.add_child(item)
			can_add -= 1
			cooldown = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hitbox.has_overlapping_bodies():
		add_item()
	if can_add == 0:
		queue_free()
	if cooldown > 0:
		cooldown -= 1
