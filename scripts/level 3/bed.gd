extends StaticBody2D
@onready var bed: Sprite2D = $Bed

@onready var trigger: Area2D = $trigger
@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/player.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
@onready var one_bed: Sprite2D = $OneBed
@onready var double_bed: CollisionShape2D = $DoubleBed
@onready var single: CollisionShape2D = $Single
@onready var double: CollisionShape2D = $trigger/Double
@onready var single_bed: CollisionShape2D = $trigger/SingleBed


func _ready():
	if get_tree().current_scene.name == "Bed":
			bed.visible = false
			one_bed.visible = true
			double_bed.disabled = true
			single.disabled = false
			double.disabled = true
			single_bed.disabled = false
			Stage3State.add_anomaly()
	else:
			bed.visible = true
			one_bed.visible = false
			double_bed.disabled = false
			single.disabled = true
			double.disabled = false
			single_bed.disabled = true
		
			

var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "BED")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	bed.modulate = Color(1.3, 1.3, 1.3)
	one_bed.modulate = Color(1.3, 1.3, 1.3)
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
	bed.modulate = Color.WHITE
	one_bed.modulate = Color.WHITE


	if balloon:
		balloon.queue_free()
		balloon = null
