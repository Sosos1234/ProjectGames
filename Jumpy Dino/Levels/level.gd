extends Node2D

var max_level = 0
var posMaxYForGeneration = 100
var posMinYForGeneration = 700
var maxPosPlatform = 0
var posPlatform = 0
var level_templates = [
	[0, 50, 150, 300, 400, 540],
	[0, 150, 300, 420, 480, 500],
	[0, 200, 250, 400, 460, 520],
	[0, 500, 400, 300, 200, 100],
	[20, 200, 300, 100, 540, 250]
]

var current_level = 0
var platform_scene = preload("res://objects/platform.tscn")

func _ready():
	generate_level(posMaxYForGeneration, posMinYForGeneration)

func generate_level(posMaxYForGeneration, posMinYForGeneration):
	print(posMinYForGeneration)
	print(posMaxYForGeneration)
	for x in level_templates[current_level % level_templates.size()]:
		var platform = platform_scene.instantiate()
		platform.position.x = x
		platform.position.y = randf_range(posMaxYForGeneration, posMinYForGeneration)
		posPlatform = platform.position.y
		add_child(platform)
		if maxPosPlatform > posPlatform:
			maxPosPlatform = posPlatform
	current_level += 1

func _process(delta):
	var cam = get_node("Player/Camera2D")
	%WallOfDeath.position.y = cam.limit_bottom + 100
	if $Player.position.y < (maxPosPlatform+300):
		posMinYForGeneration = posMaxYForGeneration
		posMaxYForGeneration = posMaxYForGeneration - 600
		generate_level(posMinYForGeneration, posMaxYForGeneration)

func _on_area_2d_body_entered(body):
	var cam = get_node("Player/Camera2D")
	if body.name == "Player":
		body.velocity.y = 0
		body.speed = 0
		body.gravity = 0 

func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall1.position.x + 70
		print(%transitionWall1.position.x, "left")

func _on_area_2d_3_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall2.position.x - 10
		print(%transitionWall2.position.x, "right")
