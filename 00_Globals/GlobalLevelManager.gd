extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChanged( bounds: Array[Vector2] )
signal Player2Turn
signal PartnerTurn
signal Player4Turn
signal Player3Turn

const REQUIRED_CORRECT : int = 4

var is_game_over : bool = false
var current_correct : int = 0
var current_tilemap_bounds : Array[Vector2]
var target_transition : String 
var position_offset : Vector2
var isAnomaly : bool = false
var random : int = 0

var current_level_index = 0
const starter_levels : Array[ String ] = [
	"res://scenes/Level1/Anomalies/Level1_noAnomaly.tscn",
	"res://scenes/Level 2/Level2Scenes/Level2_Base.tscn",
	"res://scenes/level 3/GameScenes/level_3.tscn",
	"res://scenes/level-4/scenarios/wedding_level.tscn",
	"res://scenes/level-4/scenarios/wedding_cutscene.tscn"
]

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()

func return_randomInt() -> int:
	var is_even : bool
	var check_even = randi()
	if check_even % 2 == 0:
		is_even = true
	else:
		is_even = false
		
		
	if current_level_index == 0:
		if is_even:
			isAnomaly = false
			return 0
		else:
			isAnomaly = true
			random = randi_range(1,5)
	elif current_level_index == 1:
		if is_even:
			isAnomaly = false
			return 0
		else:
			isAnomaly = true
			random = randi_range(1,20)
	elif current_level_index == 2:
		if is_even:
			isAnomaly = false
			return 0
		else:
			isAnomaly = true
			random = randi_range(1, 23)
	elif current_level_index == 3:
		if is_even:
			isAnomaly = false
			return 0
		else:
			isAnomaly = true
			random = randi_range(1, 10)
	return random

func ChangeTileMapBounds( bounds: Array[Vector2] ) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)

func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2
) -> void:	
	if is_game_over:
		return
	
	if current_correct == 4:
		current_correct = 0
		current_level_index += 1
		isAnomaly = false
		load_next_level()
		return

	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset

	await SceneTransition.fade_out()

	level_load_started.emit()

	await get_tree().process_frame # Level Transition

	get_tree().change_scene_to_file( level_path )
	
	await get_tree().process_frame

	get_tree().paused = false

	await SceneTransition.fade_in()

	level_loaded.emit()
	
	PartnerTurn.emit()

	pass

func load_next_level() -> void:
	get_tree().paused = true
	
	await SceneTransition.fade_out()
	
	if current_level_index == 1:
		Player2Turn.emit()
	elif current_level_index == 2:
		Player3Turn.emit()
	elif current_level_index == 3:
		Player4Turn.emit()
	elif current_level_index == 4:
		get_tree().change_scene_to_file( starter_levels[current_level_index] )
		get_tree().process_frame
		get_tree().paused = false
		await SceneTransition.fade_in()
		HealthHud.heart.visible = false
		return
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( starter_levels[current_level_index] )
	
	await get_tree().process_frame
	
	PartnerTurn.emit()
	
	await get_tree().process_frame
	
	get_tree().paused = false
	
	await SceneTransition.fade_in()
	
	level_loaded.emit()
	pass
