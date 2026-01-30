extends Area2D

# 1. Preload your friend's specific balloon scene
const BALLOON_SCENE = preload("res://scenes/level 3/dialogueBox/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	area_exited.connect(_on_area_exited)

func action() -> void:
	if dialogue_resource:
		# 2. Swap 'show_example_dialogue_balloon' for 'show_dialogue_balloon_scene'
		# This tells the manager to use YOUR custom scene instead of the default one.
		DialogueManager.show_dialogue_balloon_scene(BALLOON_SCENE, dialogue_resource, dialogue_start)

func _on_area_exited(_area: Area2D) -> void:
	DialogueManager.terminate_all_dialogue()
