extends State
var roam_count
var timer
var dir = 1

func enter():
	target.modulate.g = 0.5
	target.modulate.b = 0.5
	roam_count = 0
	timer = target.get_node("Timer")
	timer.start(0.5)
	var p = Global.get_player()
	if p:
		dir = sign(p.global_position.x - target.global_position.x)

func update(delta):
	if timer.time_left == 0:
		roam_count += 1
		if roam_count % 2 == 0:
			var p = Global.get_player()
			if p:
				dir = sign(p.global_position.x - target.global_position.x)
			timer.start(0.5)
	target.velocity.x = move_toward(target.velocity.x, dir * 200, 50)

func exit():
	target.modulate.g = 1
	target.modulate.b = 1

func try_transition() -> State:
	if roam_count == 12:
		return get_node("../Idle")
	return null
