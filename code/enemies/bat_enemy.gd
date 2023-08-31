extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1

func jump():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	velocity.x = direction * SPEED

	move_and_slide()


func _on_flying_timeout():
	jump()

func _ready():
	if Global.is_map_ready:
		$AnimatedSprite2D.play("default")
		$Flying.start()
		$DirectionTimer.start()

func _on_direction_timer_timeout():
	if direction == -1:
		direction = 1
	else: direction = -1
