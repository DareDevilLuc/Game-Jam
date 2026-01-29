extends StaticBody2D


@onready var trigger: Area2D = $trigger
@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/player.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
@onready var parcel: Sprite2D = $Parcel
@onready var parcel_3: Sprite2D = $Parcel3
@onready var parcel_2: Sprite2D = $Parcel2
@onready var parcel_4: Sprite2D = $Parcel4


var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null


func _ready():
	if get_tree().current_scene.name == "Box":
		parcel_4.visible = true;
	else:
		parcel_4.visible = false;
				



func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "BOX")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	parcel.modulate = Color(1.3, 1.3, 1.3)
	parcel_2.modulate = Color(1.3, 1.3, 1.3)
	parcel_3.modulate = Color(1.3, 1.3, 1.3)
	parcel_4.modulate = Color(1.3, 1.3, 1.3)

	interact_start = interact.instantiate()
	add_child(interact_start)
	var icon = interact_start.get_child(0)
	icon.position = body.global_position + Vector2(1050, 400)



func _on_trigger_body_exited(body):
	if body.name != "Player":
		return
	if interact_start:
		interact_start.queue_free()
		interact_start = null


	player_in_range = false
	dialogue_open = false
	parcel.modulate = Color.WHITE
	parcel_2.modulate = Color.WHITE
	parcel_3.modulate = Color.WHITE
	parcel_4.modulate = Color.WHITE

	if balloon:
		balloon.queue_free()
		balloon = null
