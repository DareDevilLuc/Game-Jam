extends StaticBody2D
@onready var vanity_chair: Sprite2D = $VanityChair
@onready var vanity_char_2: Sprite2D = $VanityChar2



func _ready():
	if get_tree().current_scene.name != "Level 3":
			randomize()
			var anomally := randi() % 2 == 0
			if (anomally):
				vanity_chair.visible = false
				vanity_char_2.visible = true
				Stage3State.add_anomaly()
			else:
				vanity_chair.visible = true
				vanity_char_2.visible = false
