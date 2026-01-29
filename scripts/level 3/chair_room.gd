extends StaticBody2D
@onready var vanity_chair: Sprite2D = $VanityChair
@onready var vanity_char_2: Sprite2D = $VanityChar2



func _ready():
	if get_tree().current_scene.name == "Chair":
				vanity_chair.visible = false
				vanity_char_2.visible = true
				Stage3State.add_anomaly()
	else:
				vanity_chair.visible = true
				vanity_char_2.visible = false
