extends StaticBody2D
@onready var trigger: Area2D = $trigger
@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/newDialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/player.dialogue")
@onready var sink: Sprite2D = $Sink
@onready var side_isle: Sprite2D = $SideIsle
@onready var plate: Sprite2D = $Plate
@onready var plate_2: Sprite2D = $Plate2
@onready var sink_anommaly: Sprite2D = $SinkAnommaly

var balloon: Node = null
var player_in_range := false
var dialogue_open := false
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")
var interact_start: Node = null

func _ready():
	if get_tree().current_scene.name != "Level 3":
		randomize()
		var show_plates := randi() % 2 == 0
		var sink_anomally := randi() % 8 == 0
		
		if (sink_anomally):
			sink.visible = true
			sink_anommaly.visible = false
			Stage3State.add_anomaly()
		else:
			sink.visible = false
			sink_anommaly.visible = true
			
		plate.visible = show_plates
		plate_2.visible = show_plates
		if show_plates:
			Stage3State.add_anomaly()
		

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_res, "SINK")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return

	player_in_range = true
	sink.modulate = Color(1.3, 1.3, 1.3)
	side_isle.modulate= Color(1.3, 1.3, 1.3)
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
	sink.modulate = Color.WHITE
	side_isle.modulate=Color.WHITE

	if balloon:
		balloon.queue_free()
		balloon = null
