extends Node

const PLAYER2 = preload("res://scenes/Level 2/player2.tscn")
var player : Player2
var player_spawned : bool = false
func _ready() -> void:
	await LevelManager.Player2Turn
	add_player_instance()

func add_player_instance() -> void:
	player = PLAYER2.instantiate()
	player.name = "Player2"

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )

func unparent_player( _p : Node2D ) -> void:
	_p.remove_child( player )
