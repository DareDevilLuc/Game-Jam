extends CharacterBody2D

var in_range: bool = false

func _process(_delta) -> void:
	if in_range == true and Input.is_action_just_pressed("interact"):
		print("player interact")
		DialogueManager.show_example_dialogue_balloon(load("res://assets/level-4/dialogues/parent.dialogue"), "dad_start")
		in_range = false;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("player in")
		in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
