extends CharacterBody2D

@onready var player: CharacterBody2D = get_node("../Player") 
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta):
	velocity = Vector2.ZERO  
	move_and_slide()          
	face_player()

func face_player():
	var dir: Vector2 = player.global_position - global_position

	if abs(dir.x) > abs(dir.y):
		sprite.play("idleSide")
		sprite.flip_h = dir.x > 0
	elif dir.y < 0:
		sprite.play("idleBack")
	else:
		sprite.play("idleFront")
