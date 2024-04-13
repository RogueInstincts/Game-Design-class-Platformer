extends Area2D

@onready var platformer = $".."

var spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_overlapping_bodies() and not spawned:
		var enemy = load("res://enemy.tscn")
		var spawn1 = enemy.instantiate()
		spawn1.transform.origin = Vector2(64, 0)
		add_child(spawn1)
		spawn1.platformer = platformer
		var spawn2 = enemy.instantiate()
		spawn2.transform.origin = Vector2(128, 0)
		add_child(spawn2)
		spawn2.platformer = platformer
		spawned = true
