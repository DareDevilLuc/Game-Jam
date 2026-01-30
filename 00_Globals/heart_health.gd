extends CanvasLayer

@onready var heart :Sprite2D = $Control/Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func damage_heart() -> void:
	if heart.frame != 3:
		heart.frame += 1
		return

	pass



func _on_heart_break() -> void:
	LevelManager.is_game_over = true
	heart.frame += 1
	print("should be dead")
	# Fade to black (do not change level). Start fade without awaiting
	SceneTransition.fade_out()
	get_tree().paused = true
