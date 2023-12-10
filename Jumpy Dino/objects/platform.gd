extends Node2D

func _ready():
	Signals.connect("GameStarted", Game)

func Game():
	if $"../Player".position.y < (self.position.y-1000):
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Player": 
		$StaticBody2D/CollisionShape2D.position.x += 5000

func _on_area_2d_body_exited(body):
	if body.name == "Player": 
		$StaticBody2D/CollisionShape2D.position.x -= 5000 

