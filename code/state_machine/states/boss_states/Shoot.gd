extends State

# node refs
@onready var tran_timer = $"../../../Timers/ShootTimer"
@onready var transition_node = $"../../Transitions"
@onready var rocks = $"../../../rocks"

func enter():
	rocks.disable()
	tran_timer.start()
	target.get_node("Sprite").play("shoot")


func update(delta):
		target.move(delta)
	
func exit():
	transition_node.shoot = false
	tran_timer.stop()

func try_transition():
	if transitions.to_cool_down():
		return get_node("../CoolDown")
	if transitions.to_stomp():
		return get_node("../Stomp")
	if transitions.to_shoot():
		return get_node("../Shoot")


func _on_shoot_timer_timeout():
	transition_node.stomp = false
	transition_node.cool_down = true
	transition_node.shoot = false
