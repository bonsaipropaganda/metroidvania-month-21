extends DamageHitbox

#func _ready():
#	disable()

func use():
	print("used")
	var timer = get_node("../../../Timers/AttackDurationTimer")
	
	visible = true
	enable()
	
	timer.start(0.7)
	await timer.timeout
	
	visible = false
	disable()
