extends Node2D

@onready var heart :Sprite2D = $Sprite2D
signal heart_break

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down") and heart.frame < 4:
		heart.frame += 1
	elif heart.frame == 4:
		heart_break.emit()
	pass
