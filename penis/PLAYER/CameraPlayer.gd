extends Camera2D

var maxPositionY: float = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if maxPositionY > $"..".position.y:
		maxPositionY = $"..".position.y
		self.limit_bottom = maxPositionY + 196
