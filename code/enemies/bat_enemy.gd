extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -300

# node refs
@onready var hit_box = $DamageHitbox

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1

@export var current_health = 1:
	set(value):
		current_health = value
		SfxManager.sword_hit.play()
		if current_health <= 0:
			die()

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
		$AnimatedSprite2D.flip_h = false
	else: 
		direction = -1
		$AnimatedSprite2D.flip_h = true

func die():
	queue_free()

func _on_damage_hurtbox_damage_received(amount, damage_source):
	if damage_source.is_in_group("player_attack"):
		current_health -= 1
		
		$DamageHurtbox.do_iframes()
		modulate.a = 0.5
		await $DamageHurtbox.i_timer.timeout
		modulate.a = 1
