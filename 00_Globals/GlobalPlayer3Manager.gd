extends Node

const PLAYER3 = preload("res://scenes/level 3/mc.tscn")
var player
var player_spawned : bool = false
func _ready() -> void:
	await LevelManager.Player3Turn
	add_player_instance()
	print("Player3 Instance")

func add_player_instance() -> void:
	player = PLAYER3.instantiate()
	player.name = "Player"

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )

func unparent_player( _p : Node2D ) -> void:
	_p.remove_child( player )
