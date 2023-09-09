extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCEL = 30
const FLOOR_DRAG = .8

var wander = false
var direction = 0

@export var current_health = 2:
	set(value):
		current_health = value
		if current_health <= 0:
			die()

# node refs
@onready var hit_box = $DamageHitbox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$StateMachine.init_machine(self, $StateMachine/States/CoolDown)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if direction == 0:
		if is_on_floor():
			velocity.x *= FLOOR_DRAG
	
	$StateMachine.update(delta)

func die():
	queue_free()

func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()


func _on_damage_hurtbox_damage_received(amount, damage_source):
	if damage_source.is_in_group("player_attack"):
		current_health -= amount
		
		var kb_dir = sign(global_position.x - damage_source.global_position.x)
		velocity = Vector2(kb_dir * 100, -100)
		
		$DamageHurtbox.do_iframes()
		modulate.a = 0.5
		await $DamageHurtbox.i_timer.timeout
		modulate.a = 1
