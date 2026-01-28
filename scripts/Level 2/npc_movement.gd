extends CharacterBody2D

@export var speed: int = 80
@export var walk_distance: int = 500
@export var idle_chance: float = 0.005

@onready var anim = $Body_npc 

var start_pos: Vector2
var direction: int = 1 
var is_waiting: bool = false

func _ready():
	start_pos = global_position
	anim.play("walk_side")

func _physics_process(_delta: float):
	if is_waiting:
		return
		
	if randf() < idle_chance:
		start_random_idle()
		return

	velocity.x = speed * direction
	
	anim.flip_h = (velocity.x > 0)
	
	move_and_slide()
	
	var current_dist = global_position.distance_to(start_pos)
	if current_dist >= walk_distance:
		reach_edge()

func start_random_idle():
	is_waiting = true
	velocity = Vector2.ZERO
	anim.play("idle_side")
	
	await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
	
	is_waiting = false
	anim.play("walk_side")

func reach_edge():
	is_waiting = true
	velocity = Vector2.ZERO
	anim.play("idle_side")
	
	await get_tree().create_timer(1.5).timeout
	
	direction *= -1
	start_pos = global_position
	
	is_waiting = false
	anim.play("walk_side")
