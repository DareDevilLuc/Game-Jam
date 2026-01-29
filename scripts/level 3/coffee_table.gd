extends StaticBody2D
@onready var carpet_anomally: Sprite2D = $CarpetAnomally
@onready var carpet_anomally_2: Sprite2D = $CarpetAnomally2

func _ready():
	if get_tree().current_scene.name == "Table":
				carpet_anomally.visible = true
				carpet_anomally_2.visible = true
				Stage3State.add_anomaly()
	else:
				carpet_anomally.visible = false
				carpet_anomally_2.visible = false
