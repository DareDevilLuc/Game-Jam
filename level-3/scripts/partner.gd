extends CharacterBody2D

@onready var player: CharacterBody2D = get_node("../Player") 
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var trigger: Area2D = $trigger
@onready var collision_shape_2d: CollisionShape2D = $trigger/CollisionShape2D

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

@onready var balloon_scene = preload("res://dialogueBox/balloon.tscn")
@onready var dialogue_res = preload("res://dialogue/partner.dialogue")
var balloon: Node = null
var dialogue_open := false

func _on_trigger_body_entered(body):
	if body.name != "Player":
		return
	if dialogue_open:
		return

	dialogue_open = true

	balloon = balloon_scene.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_res, "partner_intro")


	

func _on_trigger_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return

	if balloon:
		balloon.queue_free()
		balloon = null
	dialogue_open = false
