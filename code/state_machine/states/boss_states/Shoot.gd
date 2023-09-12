extends State

# node refs
@onready var tran_timer = $"../../../Timers/ShootTimer"
@onready var transition_node = $"../../Transitions"
@onready var rocks = $"../../../rocks"
@onready var shoot_webs = $"../../../ShootingWebs"
@onready var gen_anims = $"../../../AnimationPlayer"
@onready var sprite = $"../../../Sprite"

func enter():
	shoot_webs.enable()
	rocks.disable()
	tran_timer.start()
	target.get_node("Sprite").play("shoot")
	gen_anims.play("shoot")


func update(delta):
		target.move(delta)
	
func exit():
	transition_node.shoot = false
	tran_timer.stop()
	gen_anims.stop()

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
