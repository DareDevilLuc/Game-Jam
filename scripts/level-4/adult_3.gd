extends CharacterBody2D

var in_range: bool = false

const dialogue_resource = preload("res://assets/level-4/dialogues/npc.dialogue")
const custom_balloon_path = "res://scenes/level 3/dialogueBox/balloon.tscn"


func _process(_float) -> void:
	if in_range and Input.is_action_just_pressed("interact"):
		if get_current_scene() == "Wedding-9":
			DialogueManager.show_dialogue_balloon_scene(custom_balloon_path, dialogue_resource, "anomaly_adult3")
		
		in_range = false
	
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true
		print("bro is in range")

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false

func get_current_scene() -> String:
	return get_tree().current_scene.name
