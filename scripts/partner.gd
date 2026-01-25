extends CharacterBody2D

# We use a regular variable because the Player is in a different scene context
var player: CharacterBody2D 

@export var SPEED: int = 150 # Lowered slightly so they don't bump into you
@export var ACCELERATION: int = 500
@export var FRICTION: int = 200

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var body: AnimatedSprite2D = $Body

# Tracks the last direction so idle animations look natural
var last_direction: String = "down"

func _ready() -> void:
	# SEARCH LOGIC: This looks for the "Player" node anywhere in the active game tree
	# This fixes the "nil" error you were getting
	player = get_tree().root.find_child("Player", true, false)
	
	if player == null:
		print("Partner Error: Could not find Player node in the Scene Tree!")
	
	# Tuning the follow distances (200 was too far, 40-60 is better for a partner)
	nav_agent.path_desired_distance = 40.0
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_max_distance = 100.0

func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	set_movement_target()
	
	# Calculate direction toward the next path point
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
	# Updates the goal position to where the player is standing
	nav_agent.target_position = player.global_position

func update_animation(dir: Vector2, type: String) -> void:
	# If moving, update the direction string
	if dir != Vector2.ZERO:
		if abs(dir.x) > abs(dir.y):
			last_direction = "side"
			body.flip_h = dir.x > 0 # Flips sprite based on left/right movement
		elif dir.y < 0:
			last_direction = "up"
		else:
			last_direction = "down"
			
	# Plays the sliced animations we set up earlier: e.g., "walk_side" or "idle_up"
	body.play(type + "_" + last_direction)
