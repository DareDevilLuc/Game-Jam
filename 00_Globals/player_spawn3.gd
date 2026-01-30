extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if Player3Manager.player_spawned == false:
		Player3Manager.set_player_position( global_position )
		Player3Manager.player_spawned = true
