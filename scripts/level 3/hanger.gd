extends StaticBody2D
@onready var hanger: Sprite2D = $Hanger
@onready var hanger_anomally: Sprite2D = $HangerAnomally

func _ready():
	if get_tree().current_scene.name != "Level 3":
			randomize()
			var anomally := randi() % 15 == 0
			if (anomally):
				hanger.visible = false
				hanger_anomally.visible = true
				Stage3State.add_anomaly()
			else:
				hanger.visible = true
				hanger_anomally.visible = false
