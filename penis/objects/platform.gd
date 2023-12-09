extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player": 
		$StaticBody2D/CollisionShape2D.position.x += 5000 

func _on_area_2d_body_exited(body):
	if body.name == "Player": 
		$StaticBody2D/CollisionShape2D.position.x -= 5000 
