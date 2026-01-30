extends Node

const PLAYER = preload("uid://bcqlw4c6fujdw")

var player : Player
var player_spawned : bool = false
func _ready() -> void:
	var heart = get_tree().current_scene
	await heart.heart_break
	add_player_instance()

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )

func unparent_player( _p : Node2D ) -> void:
	_p.remove_child( player )
