extends State

# node refs

func enter():
	target.get_node("Sprite").play("default")


func update(delta):
		target.move(delta)
	
func exit():
	pass

func try_transition():
	if transitions.to_cool_down():
		return get_node("../CoolDown")
	if transitions.to_stomp():
		return get_node("../Stomp")
	if transitions.to_shoot():
		return get_node("../Shoot")


func _on_wander_timer_timeout():
	pass
