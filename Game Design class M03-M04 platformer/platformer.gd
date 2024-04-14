extends Node2D

@onready var player = $player
@onready var label = $view/points

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	label.set_text(": " + str(Global.lives) + "\n\n: " + str(Global.gold))
