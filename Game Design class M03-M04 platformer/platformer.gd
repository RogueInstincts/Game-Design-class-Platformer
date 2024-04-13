extends Node2D

@onready var player = $player
@onready var label = $view/points
@onready var gold = 0
@onready var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	label.set_text(": " + str(lives) + "\n\n: " + str(gold))
