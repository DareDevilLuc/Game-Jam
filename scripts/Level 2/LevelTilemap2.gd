class_name LevelTileMap2 extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTileMapBounds(GetTilemapBounds())

func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	# Use the actual tile size of your TileSet (e.g., 16x16 or 32x32)
	var tile_size = tile_set.tile_size 
	var used_rect = get_used_rect()

	# Convert tile coordinates to global pixel coordinates
	# We use global_position in case your Level/Floor is moved in the Game scene
	var top_left = global_position + Vector2(used_rect.position) * Vector2(tile_size)
	var bottom_right = global_position + Vector2(used_rect.end) * Vector2(tile_size)

	bounds.append(top_left)
	bounds.append(bottom_right)

	return bounds
