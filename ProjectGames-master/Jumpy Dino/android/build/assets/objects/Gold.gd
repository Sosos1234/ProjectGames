extends Node2D

func _ready():
	pass 

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.playerMoney += 5
		queue_free()
