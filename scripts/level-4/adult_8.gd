extends CharacterBody2D

var in_range: bool = false

const dialogue_resource = preload("res://assets/level-4/dialogues/npc.dialogue")
const custom_balloon_path = "res://scenes/level 3/dialogueBox/balloon.tscn"

func _process(_delta) -> void:
	if in_range == true and Input.is_action_just_pressed("interact"):
		print("player interact")
		DialogueManager.show_dialogue_balloon_scene(custom_balloon_path, dialogue_resource, "normal_adult8")
		in_range = false;


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("player in")
		in_range = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
