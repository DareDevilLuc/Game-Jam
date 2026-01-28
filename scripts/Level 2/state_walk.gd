class_name State_Walk extends State

@export var move_speed: float = 125.0
@onready var idle: State_Idle = $"../Idle"


# What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

# What happens when the player exits this state
func Exit() -> void:
	pass
	
	
# during _process update in this State
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null
