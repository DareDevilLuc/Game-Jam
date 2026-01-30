extends StaticBody2D

@onready var sprite = $Sprite2D

func _process(_float) -> void:
	if get_current_scene() == "Wedding-10":
		sprite.flip_h = true
	

func get_current_scene() -> String:
	return get_tree().current_scene.name
