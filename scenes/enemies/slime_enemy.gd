extends CharacterBody2D

signal play_death_sound

const SPEED = 30.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

var death_sound_played = false

# node refs
@onready var animation_player = $AnimatedSprite2D
@onready var ray_right = $RightRay
@onready var ray_left = $LeftRay
@onready var ray_down_right = $RightDownRay
@onready var ray_down_left = $LeftDownRay

func _ready():
	play_death_sound.connect(_death_sound)
	animation_player.play("default")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if !ray_down_right.is_colliding():
		direction = -1
	elif !ray_down_left.is_colliding():
		direction = 1
	
	if ray_right.is_colliding():
		direction = -1
	elif ray_left.is_colliding():
		direction = 1
	
	move_and_slide()

func _death_sound():
	if !death_sound_played:
		SfxManager.sword_hit.play()
	death_sound_played = true

func _on_damage_hurtbox_damage_received(amount, damage_source):
	if damage_source.is_in_group("player_attack"):
		play_death_sound.emit()
		animation_player.play("die")
		await animation_player.animation_finished
		queue_free()
