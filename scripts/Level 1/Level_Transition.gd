@tool
class_name LevelTransition extends Area2D

enum SIDE { LEFT, RIGHT, TOP, BOTTOM }

var level : Array[ String ] = [
	"res://scenes/Level1/Anomalies/Level1_noAnomaly.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly1.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly2.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly3.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly3.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly4.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly5.tscn",
	"res://scenes/Level1/Anomalies/Level1_Anomaly6.tscn"
]

var level2 : Array[ String ] = [
	"res://scenes/Level 2/Level2Scenes/Level2_Base.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An1.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An2.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An3.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An4.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An5.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An6.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An7.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An8.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An9.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An10.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An11.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An12.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An13.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An14.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An15.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An16.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An17.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An18.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An19.tscn",
	"res://scenes/Level 2/Level2Scenes/Lvl2_An20.tscn",
]

var level3 : Array[ String ] = [
	"res://scenes/level 3/GameScenes/level_3.tscn",
	"res://scenes/level 3/GameScenes/level_3_bed.tscn",
	"res://scenes/level 3/GameScenes/level_3_bone.tscn",
	"res://scenes/level 3/GameScenes/level_3_box.tscn",
	"res://scenes/level 3/GameScenes/level_3_chair.tscn",
	"res://scenes/level 3/GameScenes/level_3_clock.tscn",
	"res://scenes/level 3/GameScenes/level_3_coffee.tscn",
	"res://scenes/level 3/GameScenes/level_3_dining.tscn",
	"res://scenes/level 3/GameScenes/level_3_drawer.tscn",
	"res://scenes/level 3/GameScenes/level_3_food.tscn",
	"res://scenes/level 3/GameScenes/level_3_fridge.tscn",
	"res://scenes/level 3/GameScenes/level_3_hanger.tscn",
	"res://scenes/level 3/GameScenes/level_3_miniTable.tscn",
	"res://scenes/level 3/GameScenes/level_3_painting.tscn",
	"res://scenes/level 3/GameScenes/level_3_phone.tscn",
	"res://scenes/level 3/GameScenes/level_3_puppy.tscn",
	"res://scenes/level 3/GameScenes/level_3_shelf.tscn",
	"res://scenes/level 3/GameScenes/level_3_sink.tscn",
	"res://scenes/level 3/GameScenes/level_3_TV.tscn",
	"res://scenes/level 3/GameScenes/level_3_utensils.tscn",
	"res://scenes/level 3/GameScenes/level_3_vanity.tscn",
	"res://scenes/level 3/GameScenes/level_3_window.tscn",
	"res://scenes/level 3/GameScenes/level_3_world.tscn",
]
@export var target_transition_area : String = "LevelTransition"

@export_category("Collision Area Settings")

@export var side : SIDE = SIDE.LEFT :
	set(_s):
		side = _s
		_update_area()

@export_range(1,12,1, "or_greater") var size : int = 2 :
	set(_v): 
		size = _v
		_update_area()

@export var snap_to_grid : bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()

	await LevelManager.level_loaded

	monitoring = true

	body_entered.connect(_player_entered)
	
	pass

func _random_level() -> String:
	if level.is_empty():
		return ""
	if LevelManager.current_level_index == 0:
		return level[LevelManager.return_randomInt()]
	if LevelManager.current_level_index == 1:
		return level2[LevelManager.return_randomInt()]
	if LevelManager.current_level_index == 2:
		return level3[LevelManager.return_randomInt()]
	else:
		return ""

	

func _player_entered(_p : Node2D) -> void:
	if (name == "LevelTransition" and not LevelManager.isAnomaly) or (name == "LevelTransition2" and LevelManager.isAnomaly):
		HealthHud.damage_heart()
	else:
		LevelManager.current_correct += 1
	LevelManager.load_new_level( _random_level(), target_transition_area, get_offset() )
	pass

func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	if LevelManager.current_level_index == 0:
		PlayerManager.set_player_position( global_position + LevelManager.position_offset )
	if LevelManager.current_level_index == 1:
		Player2Manager.set_player_position( global_position + LevelManager.position_offset )
	if LevelManager.current_level_index == 2:
		Player3Manager.set_player_position( global_position + LevelManager.position_offset )


func get_offset() -> Vector2:
	var player_pos
	var offset : Vector2 = Vector2.ZERO
	if LevelManager.current_level_index == 0:
		player_pos = PlayerManager.player.global_position
	elif LevelManager.current_level_index == 1:
		player_pos = Player2Manager.player.global_position
	elif LevelManager.current_level_index == 2:
		player_pos = Player3Manager.player.global_position
	

	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = 16 
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		offset.x = player_pos.x - global_position.x
		offset.y = 16 
		if side == SIDE.LEFT:
			offset.x *= -1

	return offset

func _update_area() -> void:
	var new_rect : Vector2 = Vector2(32,32)
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 16
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 16
	if side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 16
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 16
	
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")

	collision_shape.shape.size = new_rect
	collision_shape.position = new_position
