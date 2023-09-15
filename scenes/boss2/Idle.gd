extends State

@onready var to_states = [
	get_node("../Roam"),
	get_node("../Jump"),
	get_node("../Shooting"),
	]

func enter():
	target.get_node("Timer").start(4)
	target.velocity.x = 0

func update(_delta):
	pass

func exit():
	pass

func try_transition() -> State:
	if target.get_node("Timer").time_left == 0:
		to_states.shuffle()
		return to_states[0]
	return null
