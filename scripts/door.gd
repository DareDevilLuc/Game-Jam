extends Sprite2D

@onready var area := $Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		visible = false

func _on_body_exited(body):
	if body.is_in_group("player"):
		visible = true
