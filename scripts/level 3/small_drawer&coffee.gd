extends StaticBody2D
@onready var coffee: Sprite2D = $Coffee
func _ready():
	if get_tree().current_scene.name == "Coffee":
		coffee.visible = false
	else:
		coffee.visible = true
