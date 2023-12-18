extends CharacterBody2D

var umb: bool = false
var MaxScore: int = 0
var score: int 
var distance: int
var speed = 350.0
var JUMP_VELOCITY = -800.0


@onready var anim = $AnimatedSprite2D
@onready var anim2 = $AnimatedSprite2D2
@onready var anim3 = $AnimatedSprite2D3
@onready var anim4 = $AnimatedSprite2D4
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if Global.globalSkin == 0:
		JUMP_VELOCITY *= 1.1
	elif Global.globalSkin == 1:
		JUMP_VELOCITY *= 1.2
	elif Global.globalSkin == 2:
		speed *= 1.1
	Signals.connect("onPteradactyl", on_pteradactyl)
	Signals.connect("NonOnPteradactyl", non_on_pteradactyl)
	Signals.connect("MinusLive", minus_lives)
	Signals.connect("PutUpUmbrella", umbrella)
	Signals.connect("PlayerInArea", setlives)
func save_game ():
	var file = FileAccess.open(Global.save_path, FileAccess.WRITE)
	file.store_var(Global.playerMoney)
	file.store_var(Global.globalSkin)

func _physics_process(delta):
	if Global.globalSkin == 0:
		anim.hide()
		anim2.show()
		anim3.hide()
		anim4.hide()
	if Global.globalSkin == 1:
		anim.hide()
		anim2.hide()
		anim3.show()
		anim4.hide()
	if Global.globalSkin == 2:
		anim.hide()
		anim2.hide()
		anim3.hide()
		anim4.show()
	if Global.globalSkin == 3:
		anim.show()
		anim2.hide()
		anim3.hide()
		anim4.hide()
		
	if self.position.y <= Global.posUmb:
		umb = false
	if not is_on_floor() && umb == false:
		set_collision_layer_value(1, 1)
		set_collision_mask_value(1, 1)
		velocity.y += gravity * delta
	if umb == true:
		set_collision_layer_value(1, 0)
		set_collision_mask_value(1, 0)
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		anim.play("IDLE")
		anim2.play("IDLE")
		anim3.play("IDLE")
		anim4.play("IDLE")
		Signals.emit_signal("PlayJumpSound")
		velocity.y = JUMP_VELOCITY
		
		

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if direction == 1:
		anim.flip_h = false
		anim2.flip_h = false
		anim3.flip_h = false
		anim4.flip_h = false
	elif direction == -1:
		anim.flip_h = true
		anim2.flip_h = true
		anim3.flip_h = true
		anim4.flip_h = true

	points(self.position.y)

	move_and_slide()

func umbrella():
	if self.position.y >= Global.posUmb:
		umb = true

func minus_lives():
	Global.lives -= 1
	Signals.emit_signal("HpBarPlayer")
	if Global.lives <= 0:
		save_game()
		get_tree().change_scene_to_file("res://Levels/menu.tscn")

func on_pteradactyl():
	JUMP_VELOCITY *= 1.5
	
func non_on_pteradactyl():
	JUMP_VELOCITY /= 1.5

func points(_delta):
	distance = self.position.y - 909
	score = abs(distance) / 10
	if MaxScore < score:
		MaxScore = score
func setlives():
	Global.lives -= 3
	minus_lives()
