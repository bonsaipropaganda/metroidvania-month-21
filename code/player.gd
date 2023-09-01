extends CharacterBody2D
signal grapple(state:bool)

@export var inventory: Inventory

@export var max_speed:float = 200
@export var jump_velocity:float = 400
@export var coyote_time:float = 0.1

const MAX_FALL_SPEED = 400
const ACCEL_X = 40
const AIR_DRAG = 0.95
const FLOOR_DRAG = 0.80
const GRAPPLE_LOOK_DISTANCE = -110

# node refs
@onready var actionable_finder = $ActionableFinder

var is_talking:bool = false
var accel = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_ended_jump = false
var actionables = []
var facing := 1

var current_health = 4

func _ready():
	Global.update_player_health.connect(_on_player_health_updated)
	$StateMachine.init_machine(self, $StateMachine/States/Grounded)

func _physics_process(delta: float) -> void:
	actionables = actionable_finder.get_overlapping_areas()
	action_manager()
	if !is_talking:
		$StateMachine.update(delta)
		try_use_weapon()
	
	$GrappleVector.target_position = Vector2(sign(accel.x) * 100, GRAPPLE_LOOK_DISTANCE)

func apply_move_input(direction):
	var new_accel_x = 0
	if direction != 0:
		new_accel_x = move_toward(0, direction * max_speed, ACCEL_X)
		if facing != direction: $Sprite.scale.x *= -1
		facing = direction
	else:
		new_accel_x = 0
	return new_accel_x

func clamp_velocity():
	if (abs(velocity.x) > max_speed): # Weak clamp
		velocity.x = move_toward(velocity.x, facing*max_speed, ACCEL_X * 1.2)
	velocity.y = clampf(velocity.y, -INF, MAX_FALL_SPEED)

func move(delta:float)->void:
	# Gravity
	accel.y = gravity * delta
	
	var direction = int(Input.get_axis("left", "right"))
	accel.x = apply_move_input(direction)
	
	velocity += accel
	clamp_velocity()
	
	# Drag
	if direction == 0:
		if is_on_floor():
			velocity.x *= FLOOR_DRAG
		else:
			velocity.x *= AIR_DRAG
	
	var col = move_and_collide(velocity * delta, true)
	if col and col.get_collider() is TileMover and col.get_normal() == Vector2.UP:
		col.get_collider().touching = true
	
	move_and_slide()

func try_use_weapon():
	if $Timers/AttackDurationTimer.time_left == 0:
		if Input.is_action_just_pressed("melee_weapon"):
			$Sprite/Equipment/MeleeWeapon.use()
		elif Input.is_action_just_pressed("ranged_weapon"):
			$Sprite/Equipment/RangedWeapon.use()

func action_manager()->void:
	#if the player's taking, check the number of "balloons" in the world. if there's none
	#it means the player's not talking. mhm
	if is_talking:
		var balloon_in_the_world:int = get_tree().get_nodes_in_group("balloon").size()
		if balloon_in_the_world == 0:
			is_talking = false
	
	if actionables and Input.is_action_just_pressed("action") and is_talking==false:
		actionables[0].action()
		is_talking = true


func _on_damage_hurtbox_damage_received(amount, damage_source):
	if damage_source.is_in_group("enemy_attack"):
		current_health -= amount
		Global.update_health_ui.emit(current_health)
		print("player's current health" + str(current_health))
		

func _on_player_health_updated(new_amount):
	# sets health to new amount and updates the ui
	current_health = new_amount
	Global.update_health_ui.emit(current_health)
