extends CharacterBody2D

var MaxScore: int = 0
var score: int
var money: int
var distance: int
var speed = 350.0
var jump_velocity = -800.0

@onready var anim = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 
	
	# Handle jump.
	if is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if direction == 1:
		anim.flip_h = false
	elif direction == -1:
		anim.flip_h = true
	
	points(self.position.y)
	
	move_and_slide()

func boostJump(value):
	jump_velocity *= value 

func points(_delta):
	distance = self.position.y - 909
	score = abs(distance) / 10
	if MaxScore < score:
		MaxScore = score
	gold(score)


func gold(_delta):
	money = MaxScore / 30
