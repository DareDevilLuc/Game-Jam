extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if Player2Manager.player_spawned == false:
		Player2Manager.set_player_position( global_position )
		Player2Manager.player_spawned = true
