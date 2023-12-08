extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var PlaPos = $"../Player".position.y - 150
	$transitionWall1.position.y = PlaPos
	$transitionWall2.position.y = PlaPos
