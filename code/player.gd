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
@onready var melee_weapon = $Sprite/Equipment/MeleeWeapon
@onready var animations = $Sprite

var is_talking:bool = false
var accel = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_ended_jump = false
var actionables = []
var facing := 1
var ammo_count = 2

# weapons
@export var has_melee = false:
	set(value):
		has_melee = value
		Global.weapons_updated.emit(has_melee,has_ranged,has_grapple,has_tnt)
@export var has_ranged = false:
	set(value):
		has_ranged = value
		Global.weapons_updated.emit(has_melee,has_ranged,has_grapple,has_tnt)
@export var has_grapple = false:
	set(value):
		has_grapple = value
		Global.weapons_updated.emit(has_melee,has_ranged,has_grapple,has_tnt)
@export var has_tnt = false:
	set(value):
		has_tnt = value
		Global.weapons_updated.emit(has_melee,has_ranged,has_grapple,has_tnt)
var weapon_in_use = false
var current_health = 4 : set = set_health

func _ready():
	Global.player_checkpoint = self.position
	Global.update_player_health.connect(set_health)
	$StateMachine.init_machine(self, $StateMachine/States/Grounded)

func _physics_process(delta: float) -> void:
	actionables = actionable_finder.get_overlapping_areas()
	action_manager()
	if !is_talking:
		$StateMachine.update(delta)
		try_use_weapon()
	
	$GrappleVector.target_position = Vector2(sign(accel.x) * 100, GRAPPLE_LOOK_DISTANCE)
	apply_animations()
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

func move(delta:float):
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
	return col

func try_use_weapon():
	if $Timers/AttackDurationTimer.time_left == 0:
		if Input.is_action_just_pressed("melee_weapon") and has_melee:
			$Sprite/Equipment/MeleeWeapon.use()
			weapon_in_use = true
		elif Input.is_action_just_pressed("ranged_weapon") and has_ranged and ammo_count:
			$Sprite/Equipment/RangedWeapon.use()
			ammo_count = clamp(ammo_count - 1, 0, 2)
			var ac = get_tree().get_nodes_in_group("ammo_count").pop_back()
			if ac: ac.frame = ammo_count
			weapon_in_use = true

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
		var new_health = current_health - amount
		Global.update_player_health.emit(new_health)
		Global.update_health_ui.emit(current_health)


func set_health(new_amount):
	if new_amount < current_health:
		$DamageHurtbox.do_iframes()
		modulate.a = 0.5
		
		velocity = Vector2(-facing * 300, -100)
		Global.do_freeze_frames(0.1)
	if new_amount <= 0:
		die()
		new_amount = 4

		
	current_health = new_amount
	Global.update_health_ui.emit(current_health)
	
	await $DamageHurtbox.i_timer.timeout
	modulate.a = 1


func _on_damage_hurtbox_body_entered(body):
	if body is TileMap:
		current_health -= 1
		# if health is 4 then the player's health was reset due to dying in which case we want to let the die() function run instead of using the spike respawner :)
		if current_health < 4:
			var sr = Global.get_spike_respawner()
			if sr:
				global_position = sr.global_position
				$StateMachine.transition_state($StateMachine/States/Grounded)
				velocity = Vector2.ZERO


func die():
	global_position = Global.player_checkpoint
	$StateMachine.transition_state($StateMachine/States/Grounded)
	velocity = Vector2.ZERO
	Global.player_died.emit()


func apply_animations():
	if !weapon_in_use:
		if velocity.y:
			animations.play("jump")
		elif velocity.x:
			animations.play("run")
		else: animations.play("default")
	else:
		pass
#		animations.play("sword")


func _on_attack_duration_timer_timeout():
	weapon_in_use = false

func _on_hitbox_target_found(target):
	if target != $DamageHurtbox:
		ammo_count = clamp(ammo_count + 1, 0, 2)
		var ac = get_tree().get_nodes_in_group("ammo_count").pop_back()
		if ac: ac.frame = ammo_count
