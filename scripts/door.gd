extends Node2D

@export var slide_distance := 28
@export var slide_speed := 200.0

var start_position
var target_position
var sliding = false

func _ready():
	start_position = position
	target_position = position + Vector2(slide_distance, 0)
	
	# Correct way to connect signals in Godot 4
	$Area2D.body_entered.connect(Callable(self, "_on_body_entered"))
	$Area2D.body_exited.connect(Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		sliding = true

func _on_body_exited(body):
	if body.name == "Player":
		sliding = false

func _process(delta):
	if sliding:
		position = position.move_toward(target_position, slide_speed * delta)
	else:
		position = position.move_toward(start_position, slide_speed * delta)
