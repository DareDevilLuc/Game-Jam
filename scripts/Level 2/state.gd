class_name State extends Node
#Stores reference to the player that this State belongs to
static var player: Player2 

func _ready():
	pass 

# What happens when the player enters this state
func Enter() -> void:
	pass

# What happens when the player exits this state
func Exit() -> void:
	pass
	
# during _process update in this State
func Process( _delta : float ) -> State:
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null
