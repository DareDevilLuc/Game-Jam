class_name DiffTables extends Node2D

const NUM_FRAMES := 4

@onready var sprite = $Sprite2D

func set_frame(rng : int) -> void:
	sprite.frame = rng % NUM_FRAMES
