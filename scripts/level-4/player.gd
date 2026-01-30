extends CharacterBody2D

class_name Player4
 
@export var in_cutscene: bool = false
# speed in pixels/sec
var speed = 150
# for sprite animation
var dir  = "down"
# the animated sprite node
@onready var animated_sprite = $AnimatedSprite2D
	
 
func _physics_process(_delta):
	if in_cutscene:
		return
	
	# setup direction of movement
	var direction = Input.get_vector("left", "right", "up", "down")
	# stop diagonal moavement by listening for input then setting axis to zero
	if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		direction.y = 0
	elif Input.is_action_pressed("up") || Input.is_action_pressed("down"):
		direction.x = 0
	else:
		direction = Vector2.ZERO
	
	#normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * speed)
	update_animation(velocity)
	move_and_slide()
	
func update_animation(vel):
	var is_moving = velocity.length_squared() > 0
	
	if is_moving:
		if vel.x > 0 : dir = "right"
		elif vel.x < 0 : dir = "left"
		elif vel.y < 0 : dir = "up"
		elif vel.y > 0 : dir = "down"
		animated_sprite.play("walk_" + dir)
	else:
		animated_sprite.play("idle_" + dir)
		

func play_anim(anim_name) -> void:
	animated_sprite.play(anim_name, 1.0)
	
func slow_anim(anim_name) -> void:
	animated_sprite.play(anim_name, 0.2)

func play_stop(idle_name) -> void:
	animated_sprite.play(idle_name, 1.0)
