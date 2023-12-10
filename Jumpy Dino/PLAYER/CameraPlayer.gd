extends Camera2D

var maxPositionY: float = 10000


func _ready():
	pass 

func _process(_delta):
	if maxPositionY > $"..".position.y:
		maxPositionY = $"..".position.y
		self.limit_bottom = maxPositionY + 490
