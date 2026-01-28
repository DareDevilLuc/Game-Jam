class_name State_Idle extends State
@onready var walk: State_Walk = $"../Walk"

# What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

# What happens when the player exits this state
func Exit() -> void:
	pass
	
	
# during _process update in this State
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null
