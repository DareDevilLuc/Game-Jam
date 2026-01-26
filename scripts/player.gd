extends CharacterBody2D

const SPEED = 150.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Get the input direction for all 4 directions (WASD or Arrows)
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# For sprite animation
	if direction.x == 0 && direction.y == 0:
		animated_sprite.play("idle")
	
	if direction.x > 0:
		animated_sprite.play("walk_right")
	elif direction.x < 0:
		animated_sprite.play("walk_left")
	
	if direction.y > 0:
		animated_sprite.play("walk_down")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	
	# Movement
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
