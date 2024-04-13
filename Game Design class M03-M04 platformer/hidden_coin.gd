extends StaticBody2D

@onready var hitbox = $hitbox
@onready var platformer = $".."

var can_add = 10
var cooldown = 0

func add_coin():
	if can_add > 0 and cooldown == 0:
		platformer.gold += 1
		var coin = load("res://coin.tscn")
		coin = coin.instantiate()
		coin.transform.origin = transform.origin + Vector2(0,-20)
		platformer.add_child(coin)
		can_add -= 1
		cooldown = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hitbox.has_overlapping_bodies():
		add_coin()
	if can_add == 0:
		queue_free()
	if cooldown > 0:
		cooldown -= 1
