extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var wander = false

# node refs
@onready var hit_box = $DamageHitbox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$StateMachine.init_machine(self, $StateMachine/States/Wander)

func _physics_process(delta):
	# set the hitbox depending on mummy direction
	if velocity.x > 0:
		hit_box.position.x = 0
	else: hit_box.position.x = -13
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	$StateMachine.update(delta)

func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()

