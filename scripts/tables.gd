extends Node2D

const x = 32
const y = 46
const FRAMES = [
	Rect2(0, 0, x, y),
	Rect2(x, 0, x, y),
	Rect2(x*2, 0, x, y),
	Rect2(x*3, 0, x, y)
]

func _ready() -> void:
	var instances = get_children()  # get all 9 instances
	for i in instances.size():
		var instance = instances[i]
		# Loop frames if there are fewer than instances
		var frame_index = i % FRAMES.size()  
		instance.get_node("Sprite2D").region_rect = FRAMES[frame_index]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
