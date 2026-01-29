extends StaticBody2D

@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/player.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
@onready var vegetable: Sprite2D = $Vegetable
@onready var table: Sprite2D = $Table
@onready var fruit_basket: Sprite2D = $FruitBasket
@onready var wine: Sprite2D = $Wine
@onready var wine_right: Sprite2D = $WineRight
@onready var cutlery_2: Sprite2D = $Cutlery2
@onready var cutlery_3: Sprite2D = $Cutlery3


func _ready():
	if get_tree().current_scene.name == "Dining":
			fruit_basket.visible = false
			vegetable.visible = true
	else:
			fruit_basket.visible = true
			vegetable.visible = false
	if get_tree().current_scene.name == "Utensils":
			wine.visible = false
			wine_right.visible = true
			cutlery_2.visible = false
			cutlery_3.visible = true
	else:
			wine.visible = true
			wine_right.visible = false
			cutlery_2.visible = true
			cutlery_3.visible = false	
			


var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "DINING")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	table.modulate = Color(1.3, 1.3, 1.3)
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
	table.modulate = Color.WHITE

	if balloon:
		balloon.queue_free()
		balloon = null
