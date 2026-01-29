extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

func _process(_delta: float) -> void:
	if get_current_scene() == "2nd part wedding":
		sprite.flip_h = true

func get_current_scene() -> String:
	return get_tree().current_scene.name
