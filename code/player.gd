extends CharacterBody2D

@export var inventory: Inventory

@export var speed:float = 150
@export var jump_velocity:float = 400
@export var coyote_time:float = 0.4

const MAX_FALL_SPEED = 400
const ACCEL_X = 30
const AIR_DRAG = 0.95
const FLOOR_DRAG = 0.87

# node refs
@onready var actionable_finder = $ActionableFinder

var is_talking:bool = false
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_ended_jump = false
var actionables = []

func _ready():
	$StateMachine.init_machine(self, $StateMachine/States/Grounded)

func _physics_process(delta: float) -> void:
	actionables = actionable_finder.get_overlapping_areas()
	action_manager()
	$StateMachine.update(delta)

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clampf(velocity.y, -INF, MAX_FALL_SPEED)

func move(delta:float)->void:
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, ACCEL_X)
	else:
		if is_on_floor(): velocity.x *= FLOOR_DRAG
		else: velocity.x *= AIR_DRAG
	
	apply_gravity(delta)
	move_and_slide()

func action_manager()->void:
	#if the player's taking, check the number of "balloons" in the world. if there's none
	#it means the player's not talking. mhm
	if is_talking:
		var balloon_in_the_world:int = get_tree().get_nodes_in_group("balloon").size()
		if balloon_in_the_world == 0:
			is_talking = false
			$StateMachine.transition_state($StateMachine/States/Grounded)
	
	if actionables and Input.is_action_just_pressed("action") and is_talking==false:
		actionables[0].action()
		$StateMachine.transition_state($StateMachine/States/Frozen)
		is_talking = true
