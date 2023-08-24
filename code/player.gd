extends CharacterBody2D

var is_talking:bool = false
@export var speed:float = 100


@export var jump_velocity:float = 300
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
	var actionables = actionable_finder.get_overlapping_areas()
	
	var coyete_jump:Callable = func() -> bool:
		if not is_on_floor():
			jump_delay_value -= delta
		else:
			jump_delay_value = jump_delay


		if jump_delay_value > 0 and not actionables:
			return true
		return false

	#this part is for jumping
	var is_on_floor:bool = coyete_jump.call()
	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		velocity.y = -jump_velocity
		jump_delay_value = 0
	
	#this part is for forizontal movement
	var direction:float = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#for adding gravity!!!
	if not is_on_floor():
		velocity.y += gravity * delta
	# can't move and talk, silly human
	if !is_talking:
		move_and_slide()

func action_manager()->void:
	var actionables = actionable_finder.get_overlapping_areas()
	
	#if the player's taking, check the number of "balloons" in the world. if there's none
	#it means the player's not talking. mhm
	if is_talking:
		var balloon_in_the_world:int = get_tree().get_nodes_in_group("balloon").size()
		if balloon_in_the_world == 0:
			is_talking = false
	
	
	if actionables and Input.is_action_just_pressed("action") and is_talking==false:
		actionables[0].action()
		is_talking = true
		return
