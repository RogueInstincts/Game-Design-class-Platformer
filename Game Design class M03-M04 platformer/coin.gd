extends Sprite2D

var lifespan = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if lifespan:
		transform.origin -= Vector2(0,1)
		lifespan -= 1
	else:
		queue_free()
