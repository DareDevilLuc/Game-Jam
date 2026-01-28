extends StaticBody2D
@onready var bone: Sprite2D = $Bone
@onready var fisbone: Sprite2D = $Fisbone

func _ready():
	if get_tree().current_scene.name != "Level 3":
			randomize()
			var anomally := randi() % 6 == 0
			if (anomally):
				bone.visible = false
				fisbone.visible = true
				Stage3State.add_anomaly()
			else:
				bone.visible = true
				fisbone.visible = false
