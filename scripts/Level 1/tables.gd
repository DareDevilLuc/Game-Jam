extends Node2D


func _ready() -> void:
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is DiffTables:
			child.set_frame(i)
