extends Node2D

@onready var start_button = $Panel/start_button
@onready var main = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if start_button.button_pressed:
		main.get_tree().change_scene_to_file("res://platformer.tscn")
