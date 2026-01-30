extends CharacterBody2D

var player: CharacterBody2D = Player3Manager.player
@onready var trigger: Area2D = $trigger
@onready var collision_shape_2d: CollisionShape2D = $trigger/CollisionShape2D
@onready var sprite :AnimatedSprite2D = null
@onready var blonde: AnimatedSprite2D = $Blonde
@onready var blue: AnimatedSprite2D = $Blue
@onready var default: AnimatedSprite2D = $Default


func _ready() -> void:
	default.visible = false
	blonde.visible = false
	blue.visible = false
	
	sprite = default
	sprite.visible = true
	

func _physics_process(_delta):       
	face_player()

func face_player():
	var dir: Vector2 = player.global_position - global_position

	if abs(dir.x) > abs(dir.y):
		sprite.play("idleSide")
		sprite.flip_h = dir.x > 0
	elif dir.y < 0:
		sprite.play("idleBack")
	else:
		sprite.play("idleFront")

@onready var balloon_scene = preload("res://scenes/level 3/dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://scripts/level 3/dialogue/partner.dialogue")
@onready var interact = preload("res://scenes/level 3/dialogueBox/interact.tscn")

var balloon: Node = null
var player_in_range := false
var dialogue_open := false
var interact_start: Node = null

func _process(_delta):
	if player_in_range and not dialogue_open and Input.is_action_just_pressed("interact"):
		dialogue_open = true
		balloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		if get_tree().current_scene.name == "Level 3" and not Level3State.partner_apology_played:
			balloon.start(dialogue_res, "partner_apology")
			Level3State.partner_apology_played = true
		else:
			balloon.start(dialogue_res, "partner_intro")
		interact_start.queue_free()
		interact_start = null


func _on_trigger_body_entered(body):
	if body.name != "Player":
		return
	player_in_range = true
	sprite.modulate = Color(1.3, 1.3, 1.3)
	interact_start = interact.instantiate()
	add_child(interact_start)
	var icon = interact_start.get_child(0)
	icon.position = body.global_position + Vector2(1050, 400)

	

func _on_trigger_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return

	if interact_start:
		interact_start.queue_free()
		interact_start = null

	player_in_range = false
	dialogue_open = false
	sprite.modulate = Color.WHITE

	if balloon:
		balloon.queue_free()
		balloon = null
