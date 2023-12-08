extends Node2D

@onready var platforms = "res://Platforms/static_body_2d.tscn"

func _ready():
	pass

func _process(delta):
	$Area2D.position.y = $Player/Camera2D.limit_bottom + 50

func _on_area_2d_body_entered(body):
	var cam = get_node("Player/Camera2D")
	if body.name == "Player":
		body.velocity.y = 0
		body.speed = 0
		body.gravity = 0 
		
		
