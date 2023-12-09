extends Area2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var PlayerPos = $"../Player".position.y - 150
	$Area2D/transitionWall2.position.y = PlayerPos
	$Area2D2/transitionWall1.position.y = PlayerPos
