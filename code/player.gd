extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500

@export var jump_delay:float = 1
var jump_delay_value:float = jump_delay

# node refs
@onready var actionable_finder = $ActionableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	move(delta)
	action_manager()


func move(delta:float)->void:
	
	var coyete_jump:Callable = func() -> bool:
		if not is_on_floor():
			jump_delay_value -= delta
		else:
			jump_delay_value = jump_delay


		if jump_delay_value > 0:
			return true
		return false


	var is_on_floor:bool = coyete_jump.call()
	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		velocity.y = JUMP_VELOCITY
		jump_delay_value = 0
	
	
	var direction:float = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#for adding gravity!!!
	if not is_on_floor():
		velocity.y += gravity * delta

	

	move_and_slide()

func action_manager()->void:
	if not Input.is_action_just_pressed("ui_accept"):
		return
	var actionables = actionable_finder.get_overlapping_areas()
	if actionables:
		actionables[0].action()
		return
