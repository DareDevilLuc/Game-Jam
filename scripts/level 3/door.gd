extends StaticBody2D

@onready var trigger: Area2D = $trigger
@onready var sprite: AnimatedSprite2D = $"Open Door"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var player_near := false
var is_open := false

func _ready():
	trigger.body_entered.connect(_on_body_entered)
	trigger.body_exited.connect(_on_body_exited)
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.play("closed door")

func _on_body_entered(body):
	if body.is_in_group("player") and not is_open:
		player_near = true
		open_door()

func _on_body_exited(body):
	if body.is_in_group("player") and is_open:
		player_near = false
		close_door()

func open_door():
	is_open = true
	sprite.play("door opening")

func close_door():
	is_open = false
	sprite.play("door closing")

func _on_animation_finished():
	if sprite.animation == "door opening":
		collision_shape_2d.disabled = true
		sprite.play("door open")
		
	elif sprite.animation == "door closing":
		collision_shape_2d.disabled = false
		sprite.play("closed door")
		
