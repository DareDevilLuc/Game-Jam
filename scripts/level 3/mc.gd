extends CharacterBody2D

@onready var player: AnimatedSprite2D = $AnimatedSprite2D
var direction : String = "side"
const SPEED: float = 70.0

func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("left", "right", "up", "down")
	update_animation(input_vector)
	velocity = input_vector * SPEED
	move_and_slide()

func update_animation(input_vector: Vector2) -> void:	
	if input_vector.x < 0:
		direction = "side"
		player.play("walkSide")
		player.flip_h = false
	elif input_vector.x > 0:
		direction = "side"
		player.play("walkSide")
		player.flip_h = true
	elif input_vector.y < 0:
		direction = "back"
		player.play("walkBack")
	elif input_vector.y > 0:
		direction = "front"
		player.play("walkFront")
	else:
		if  direction == "side":
			player.play("idleSide")
		elif  direction == "back":
			player.play("idleBack")
		elif  direction == "front":
			player.play("idleFront")
	
