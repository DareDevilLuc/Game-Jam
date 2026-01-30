extends CanvasLayer

@onready var heart :Sprite2D = $Control/Sprite2D
signal heart_break


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func damage_heart() -> void:
	if heart.frame < 4:
		heart.frame += 1
		return
	heart_break.emit()
	pass
