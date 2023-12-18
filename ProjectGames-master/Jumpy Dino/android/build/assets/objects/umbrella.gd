extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		queue_free()
		Global.posUmb = self.position.y-2000
		Signals.emit_signal("PutUpUmbrella")
