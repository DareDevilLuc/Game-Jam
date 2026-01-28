extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	area_exited.connect(_on_area_exited)

func action() -> void:
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_area_exited(_area: Area2D) -> void:
	DialogueManager.terminate_all_dialogue()
