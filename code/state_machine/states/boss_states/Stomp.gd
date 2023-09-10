extends State

# node refs
@onready var tran_timer = $"../../../Timers/StompTimer"
@onready var transition_node = $"../../Transitions"
@onready var general_animations = $"../../../AnimationPlayer"
@onready var rocks = $"../../../rocks"

func enter():
	rocks.enable()
	general_animations.play("stomp")
	tran_timer.start()
	target.get_node("Sprite").play("stomp")


func update(delta):
		target.move(delta)
	
func exit():
	general_animations.stop()
	rocks.disable()
	rocks.visible = false
	tran_timer.stop()

func try_transition():
	if transitions.to_cool_down():
		return get_node("../CoolDown")
	if transitions.to_stomp():
		return get_node("../Stomp")
	if transitions.to_shoot():
		return get_node("../Shoot")


func _on_stomp_timer_timeout():
	transition_node.stomp = false
	transition_node.cool_down = false
	transition_node.shoot = true
