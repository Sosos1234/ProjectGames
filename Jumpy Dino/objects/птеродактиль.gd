extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var anim = $AnimationPlayer
@onready var pter = $AnimatableBody2D/AnimatedSprite2D

func _ready():
	if not loop:
		anim.play("move")
		anim.speed_scale = speed_scale
		set_process(false)

func _process(_delta):
	path.progress += speed
	if path.progress == 0:
		pter.offset.flip_h = true
	elif path.progress == 1:
		pter.flip_h = false
