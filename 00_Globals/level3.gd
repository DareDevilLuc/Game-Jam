extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	Player3Manager.set_as_parent( self )
	LevelManager.level_load_started.connect(_free_level)

	
func _free_level() -> void:
	Player3Manager.unparent_player( self )
	queue_free()
