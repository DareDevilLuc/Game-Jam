extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if Player4Manager.player_spawned == false:
		Player4Manager.set_player_position( global_position )
		Player4Manager.player_spawned = true
