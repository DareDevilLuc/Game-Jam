extends CharacterBody2D

var player: CharacterBody2D 

@export var SPEED: int = 125 
@export var ACCELERATION: int = 350
@export var FRICTION: int = 200

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var body: AnimatedSprite2D = $Body

var last_direction: String = "down"

func _ready() -> void:
	player = get_tree().root.find_child("Player2", true, false)
	
	if player == null:
		print("Partner Error: Could not find Player node in the Scene Tree!")
	
	nav_agent.path_desired_distance = 40.0
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_max_distance = 100.0

func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	set_movement_target()
	
	var next_path_pos = nav_agent.get_next_path_position()
	var direction: Vector2 = (next_path_pos - global_position).normalized()
	
	if not nav_agent.is_target_reached() and direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
		update_animation(direction, "walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		update_animation(Vector2.ZERO, "idle")
	
	move_and_slide()

func set_movement_target() -> void:
	
	nav_agent.target_position = player.global_position

func update_animation(dir: Vector2, type: String) -> void:

	if dir != Vector2.ZERO:
		if abs(dir.x) > abs(dir.y):
			last_direction = "side"
			body.flip_h = dir.x > 0 
		elif dir.y < 0:
			last_direction = "up"
		else:
			last_direction = "down"
			
	# Plays the sliced animations we set up earlier: e.g., "walk_side" or "idle_up"
	body.play(type + "_" + last_direction)
