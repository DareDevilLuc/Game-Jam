extends CharacterBody2D

var in_range: bool = false

@onready var animated_sprite = $AnimatedSprite2D

func _process(_delta) -> void:
	if in_range == true and Input.is_action_just_pressed("interact"):
			print("you are pressing e")
			DialogueManager.show_example_dialogue_balloon(load("res://assets/level-4/dialogues/npc.dialogue"), "partner_start")
			in_range = false;

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true
		print("bro is in range")


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false

func play_anim(anim_name) -> void:
	animated_sprite.play(anim_name, 0.5)
	
