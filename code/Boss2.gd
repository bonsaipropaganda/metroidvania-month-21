extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var hp = 30:
	set(value):
		hp = value
		SfxManager.sword_hit.play()
var facing = -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$StateMachine.init_machine(self, get_node("StateMachine/States/Idle"))

func move(delta):
	velocity.y += gravity * delta
	velocity.y = clampf(velocity.y, -INF, 500)
	velocity.x *= 0.99
	
	move_and_slide()
	
func _physics_process(delta):
	$StateMachine.update(delta)
	facing = sign(velocity.x)
	if facing == -1:
		$Sprite2D.flip_h = false
	if facing == 1:
		$Sprite2D.flip_h = true
	move(delta)

func _on_damage_hurtbox_damage_received(amount, damage_source):
	if damage_source.is_in_group("player_attack"):
		$DamageHurtbox.do_iframes()
		hp -= 1
		if hp == 0:
			queue_free()
			return
		modulate.a = 0.5

		await $DamageHurtbox.i_timer.timeout
		modulate.a = 1
