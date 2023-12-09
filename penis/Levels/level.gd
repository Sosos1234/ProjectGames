extends Node2D

func _process(delta):
	$Area2D.position.y = $Player/Camera2D.limit_bottom + 75


func _on_area_2d_body_entered(body):
	var cam = get_node("Player/Camera2D")
	if body.name == "Player":
		body.velocity.y = 0
		body.speed = 0
		body.gravity = 0 

func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall1.position.x + 70
		print(%transitionWall1.position.x, "left")

func _on_area_2d_3_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall2.position.x - 10
		print(%transitionWall2.position.x, "right")
