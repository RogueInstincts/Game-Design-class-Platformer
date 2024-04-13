extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var objects = get_overlapping_bodies()
	for i in objects:
		i.kill()
