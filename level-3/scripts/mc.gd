extends CharacterBody2D


const SPEED : float = 30


func _physics_process(_delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	move_and_slide()
	
