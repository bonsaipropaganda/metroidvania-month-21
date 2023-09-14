extends State

# node refs
@onready var state_timer = $"../../../Timers/CoolDownTimer"
@onready var transition_node = $"../../Transitions"
@onready var rocks = $"../../../rocks"
@onready var shoot_webs = $"../../../ShootingWebs"

func enter():
	transition_node.stomp = true
	transition_node.cool_down = false
	transition_node.shoot = false
	shoot_webs.disable()
	rocks.disable()
	state_timer.start()
	target.get_node("Sprite").play("default")


func update(delta):
		target.move(delta)
	
func exit():
	state_timer.stop()

func try_transition():
	if transitions.to_cool_down():
		return get_node("../CoolDown")
	if transitions.to_stomp():
		return get_node("../Stomp")
	if transitions.to_shoot():
		return get_node("../Shoot")
