extends Area2D

@onready var timer: Timer = $Timer



func _on_body_entered(_body: Node2D) -> void:
	print(Stage3State.anomalyCtr)
	timer.start()


func _on_timer_timeout() -> void:
	if Stage3State.anomalyCtr < 1:
		Stage3State.heartbreak()
		
	print("Your current heart health is: ", Stage3State.heartHealth)
	get_tree().change_scene_to_file("res://scenes/level 3/level_3_random.tscn")
	Stage3State.reset()
