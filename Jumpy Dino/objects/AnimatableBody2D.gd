extends AnimatableBody2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("default")

func _process(delta):
	if self.position.x <= 67:
		anim.flip_h = true
	if self.position.x >= 464:
		anim.flip_h = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Levels/menu.tscn")


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("onPteradactyl")


func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		Signals.emit_signal("NonOnPteradactyl")
