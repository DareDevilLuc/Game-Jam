class_name Player2 extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready():
	state_machine.Initialize(self)
	var dm = Engine.get_singleton("DialogueManager")
	if dm:
		dm.dialogue_started.connect(_on_dialogue_started)
		dm.dialogue_ended.connect(_on_dialogue_finished)

func _on_dialogue_started(_resource: DialogueResource) -> void:
	direction = Vector2.ZERO
	velocity = Vector2.ZERO
	
	state_machine.set_physics_process(false)
	state_machine.set_process(false)
	
	UpdateAnimation("idle") 

func _on_dialogue_finished(_resource: DialogueResource) -> void:
	state_machine.set_physics_process(true)
	state_machine.set_process(true)

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		var interactions = $Interactions.get_overlapping_areas()
		if interactions.size() > 0:
			interactions[0].action()
			return 
			
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = direction.normalized()
	
func _physics_process(_delta):
	move_and_slide()

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite_2d.flip_h = (cardinal_direction == Vector2.RIGHT)
	return true

func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
