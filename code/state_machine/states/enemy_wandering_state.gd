extends State

var wander_time
var wander_speed
var wander_direction

# node refs
@onready var wander_timer_node = $"../../../Timers/WanderTimer"
@onready var player_detector = $"../../../PlayerDetector"

func enter():
	target.get_node("Sprite").play("default")
	wander_time = randf_range(.25,1.5)
	wander_timer_node.start(wander_time)
	wander_speed = randi_range(25,70)
	wander_direction = [-1,1].pick_random()


func update(delta):
	if wander_timer_node.time_left > 0:
		target.velocity.x = move_toward(target.velocity.x, wander_direction * wander_speed, target.ACCEL * delta * 60)
		target.move(delta)
	# sprite and player detector faces direction of movement
	if wander_direction == 1:
		player_detector.target_position.x = 150
		target.get_node("Sprite").flip_h = false
	else:
		player_detector.target_position.x = -150
		target.get_node("Sprite").flip_h = true

func exit():
	pass

func try_transition():
#	if transitions.to_wander():
#		return get_node("../Wander")
	if transitions.to_chase():
		return get_node("../Chase")
	if transitions.to_attack():
		return get_node("../Attack")


func _on_wander_timer_timeout():
	wander_time = randf_range(.25,1.0)
	wander_timer_node.start(wander_time)
	wander_speed = randi_range(25,70)
	wander_direction = [-1,1].pick_random()
