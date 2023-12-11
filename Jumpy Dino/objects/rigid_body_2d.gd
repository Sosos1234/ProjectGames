extends RigidBody2D

func _ready():
	set_gravity_scale(0.54)

func _process(delta):
	if linear_velocity.y == 0 && (self.position.y - 200) > $"../Player".position.y :
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Levels/menu.tscn")
