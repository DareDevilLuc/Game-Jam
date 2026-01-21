extends Node2D

const x = 32
const FRAME_1 = Rect2(0, 0, 32, 46)
const FRAME_2 = Rect2(x, 0, 32, 46)
const FRAME_3 = Rect2(x*2, 0, 32, 46)
const FRAME_4= Rect2(x*3, 0, 32, 46)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance1 = $DiffTables_01
	var instance2 = $DiffTables_02

	instance1.get_node("Sprite2D").region_rect = FRAME_1
	instance2.get_node("Sprite2D").region_rect = FRAME_2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
