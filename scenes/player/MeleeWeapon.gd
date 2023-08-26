extends DamageHitbox

func use():
	var timer = get_node("../../Timers/AttackDurationTimer")
	
	visible = true
	enable()
	
	timer.start(1)
	await timer.timeout
	
	visible = false
	disable()
