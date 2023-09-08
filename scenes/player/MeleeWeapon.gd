extends DamageHitbox

# node refs
@onready var animation_player = $"../../../AnimationPlayer"

func use():
	var timer = get_node("../../../Timers/AttackDurationTimer")
	animation_player.play("melee")
	visible = true
	enable()
	
	timer.start(0.7)
	await timer.timeout

	visible = false
	disable()
