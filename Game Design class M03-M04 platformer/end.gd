extends Node2D

@onready var points = $Panel/points

# Called when the node enters the scene tree for the first time.
func _ready():
	points.set_text(": " + str(Global.lives) + "\n\n: " + str(Global.gold))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
