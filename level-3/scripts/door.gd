extends StaticBody2D

@onready var door: AnimatedSprite2D = $"../OpenDoor"

var is_player_near := false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	is_player_near = true
	play_open_sequence()

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	is_player_near = false
	play_close_sequence()

func play_open_sequence() -> void:
	door.play("door_opening")
	await door.animation_finished

	# Player might have left while opening
	if is_player_near:
		door.play("open")

func play_close_sequence() -> void:
	door.play("door_closing")
	await door.animation_finished

	# Player might have returned while closing
	if not is_player_near:
		door.play("close")
