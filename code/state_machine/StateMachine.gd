extends Node
class_name StateMachine

var current_state : Node
var target : Node # We are managing the state of an arbitrary target

func init_machine(target, init_state):
	for state in get_children():
		assert(state is State)
		state.target = target
	
	current_state = init_state
	current_state.enter()

func update(delta):
	current_state.update(delta)
	
	var new_state = current_state.try_transition()
	if new_state != null && new_state != current_state:
		transition_state(new_state)

func transition_state(new_state):
	current_state.exit()
	new_state.enter()
	
	current_state = new_state
