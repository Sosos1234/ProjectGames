extends RigidBody2D



func _ready():
	set_gravity_scale(0.4)

func _process(delta):
	if linear_velocity.y == 0 && (self.position.y - 200) > $"../Player".position.y :
		queue_free()

func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		Signals.emit_signal("MinusLive")
