extends RigidBody2D

var speed: float = 0.1

func _ready():
	Signals.connect("SpeedShishuly", speed_shishuly)

func _process(delta):
	set_gravity_scale(speed)
	if self.position.y-1500 > $"../Player".position.y :
		queue_free()

func speed_shishuly(value):
	speed = value * 0.005

func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		Signals.emit_signal("MinusLive")
