extends CanvasLayer

# This must match the path in your UI Scene tree exactly
@onready var label = $Control/TextureRect/RichTextLabel

func _ready() -> void:
	hide() # Start hidden so it doesn't block the screen

# This is the "handshake" function the DialogueManager looks for
func start(resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	show() # Make the pixel-art box visible
	
	# Get the first line of dialogue
	var line = await DialogueManager.get_next_dialogue_line(resource, title, extra_game_states)
	
	while line:
		# Update the label text
		label.text = line.text
		
		# Printing to console helps verify the code is running
		print("Dialogue Text: ", line.text) 
		
		# Small buffer to prevent accidental skipping
		await get_tree().create_timer(0.2).timeout 
		
		# Wait for the player to press Space/Enter
		await _wait_for_input()
		
		# Move to the next line. 
		# FIX: You must pass 'resource' as the first argument, then 'line.next_id'
		line = await DialogueManager.get_next_dialogue_line(resource, line.next_id, extra_game_states)
	
	# Close the box when dialogue ends
	hide()

# Helper function to pause the code until a key is pressed
func _wait_for_input():
	while true:
		if Input.is_action_just_pressed("ui_accept"):
			return
		await get_tree().process_frame
