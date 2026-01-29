extends StaticBody2D
@onready var wardrobe: Sprite2D = $Wardrobe
@onready var trigger: Area2D = $trigger
@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/player.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
@onready var wardrobe_2: Sprite2D = $Wardrobe2
@onready var wardrobe_3: Sprite2D = $Wardrobe3
func _ready():
	if get_tree().current_scene.name == "Drawer":
				wardrobe_2.visible = true
				wardrobe_3.visible = true
				wardrobe.visible = false
	else:
				wardrobe_2.visible = false
				wardrobe_3.visible = false
				wardrobe.visible = true


var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "DRAWER")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	wardrobe.modulate = Color(1.3, 1.3, 1.3)
	wardrobe_2.modulate = Color(1.3, 1.3, 1.3)
	wardrobe_3.modulate = Color(1.3, 1.3, 1.3)
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

	player_in_range = false
	dialogue_open = false
	wardrobe.modulate = Color.WHITE
	wardrobe_2.modulate = Color.WHITE
	wardrobe_3.modulate =  Color.WHITE


	if balloon:
		balloon.queue_free()
		balloon = null
