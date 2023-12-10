extends Camera2D

var maxPositionY: float = 460

func _process(_delta):
	if maxPositionY > $"..".position.y:
		maxPositionY = $"..".position.y
		self.limit_bottom = maxPositionY + 490
