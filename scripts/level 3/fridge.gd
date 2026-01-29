extends StaticBody2D

@onready var trigger: Area2D = $trigger
@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue//player.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
@onready var fridge: Sprite2D = $RefAnomally
@onready var open_fridge: Sprite2D = $OpenFridge
@onready var coffee_anomally: Sprite2D = $CoffeeAnomally



var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		fridge.visible = false
		open_fridge.visible = true
		if get_tree().current_scene.name == "Fridge":
			coffee_anomally.visible = true
			Stage3State.add_anomaly()
		else:
			coffee_anomally.visible = false
			
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "FRIDGE")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	fridge.modulate = Color(1.3, 1.3, 1.3)
	interact_start = interact.instantiate()
	add_child(interact_start)
	var icon = interact_start.get_child(0)
	icon.position = body.global_position + Vector2(450, 80)



func _on_trigger_body_exited(body):
	if body.name != "Player":
		return
	if interact_start:
		interact_start.queue_free()
		interact_start = null
	fridge.visible = true
	open_fridge.visible = false
	coffee_anomally.visible = false
	player_in_range = false
	dialogue_open = false
	fridge.modulate = Color.WHITE

	if balloon:
		balloon.queue_free()
		balloon = null
