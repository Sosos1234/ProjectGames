extends Node2D


var HaveBeenPterodactyl = false
var YPos = 150
var posMaxYForGeneration = 100
var posMinYForGeneration = 700
var posAveYForGeneration = posMinYForGeneration
var maxPosPlatform = 0
var posPlatform = 0
var level_templates = [
	[150, 200, 40, 400, 320, 500],
	[480, 150, 500, 420, 40, 300],
	[40, 200, 280, 520, 460, 150],
	[200, 500, 400, 90, 300, 140],
	[60, 200, 400, 100, 320, 250]
]
var current_level = 100
var platform_scene = preload("res://objects/platform.tscn")
var pterodactyl_scene = preload("res://objects/pterodactyl.tscn")
var shishulya_scene = preload("res://objects/rigid_body_2d.tscn")

func _ready():
	Signals.emit_signal("GameStarted")
	generate_level(posMaxYForGeneration, posMinYForGeneration)

func generate_level(posMaxYForGeneration, posMinYForGeneration):
	var positionYPlayer = $Player.position.y
	var valueForChanceOnPterodactyl = randi_range(1, 7)
	for x in level_templates[current_level % level_templates.size()]:
		var platform = platform_scene.instantiate()
		platform.position.x = x
		platform.position.y = randf_range(posAveYForGeneration, posAveYForGeneration - 100)
		posPlatform = platform.position.y
		add_child(platform)
		posAveYForGeneration -= YPos
		if maxPosPlatform > posPlatform:
			maxPosPlatform = posPlatform
	
	if current_level > 5 && current_level < 40:
		for x in 1:
			var posYPlayer = int(positionYPlayer)
			var shishulya = shishulya_scene.instantiate()
			shishulya.position.x = randi_range(20, 520)
			shishulya.position.y = randi_range(posYPlayer - 300, posYPlayer - 1000)
			add_child(shishulya)
	
	if current_level > 40:
		for x in 2:
			var posYPlayer = int(positionYPlayer)
			var shishulya = shishulya_scene.instantiate()
			shishulya.position.x = randi_range(20, 520)
			shishulya.position.y = randi_range(posYPlayer - 700, posYPlayer - 1000)
			add_child(shishulya)
	
	if current_level % valueForChanceOnPterodactyl == 0 && current_level >= 12:
		var posYPlayer = int(positionYPlayer)
		var pterodactyl = pterodactyl_scene.instantiate()
		pterodactyl.position.x = 0
		pterodactyl.position.y = randi_range(posYPlayer - 300, posYPlayer - 1000)
		add_child(pterodactyl)

	current_level += 1
	if current_level % 20 == 0 && current_level <= 60:
		YPos += 50
		for i in range(level_templates.size()):
			level_templates[i].remove_at(level_templates[i].size() - 1)

func _process(_delta):
	var cam = get_node("Player/Camera2D")
	%WallOfDeath.position.y = cam.limit_bottom + 100
	if $Player.position.y < (maxPosPlatform+300):
		posMinYForGeneration = posMaxYForGeneration
		posMaxYForGeneration = posMaxYForGeneration - 600
		generate_level(posMinYForGeneration, posMaxYForGeneration)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.velocity.y = 0
		body.speed = 0
		body.gravity = 0 
		get_tree().change_scene_to_file("res://Levels/menu.tscn")

func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall1.position.x + 70

func _on_area_2d_3_body_entered(body):
	if body.name == "Player":
		body.position.x = %transitionWall2.position.x - 10
