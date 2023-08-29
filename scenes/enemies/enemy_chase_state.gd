extends State

# node refs
@onready var exclamation_timer = $"../../../Timers/ExclamationTimer"
@onready var exclamation_sprite = $"../../../ExclamationSprite"
@onready var player_detector = $"../../../PlayerDetector"

var chase_speed = 80
var chase_direction

func enter():
	target.get_node("Sprite").play("default")
	exclamation_sprite.show()
	exclamation_timer.start()

func update(delta):
	# this sets the direction of the sprite based on where the player detector was facing
	if player_detector.target_position.x > 0:
		chase_direction = 1
	else: chase_direction = -1
	target.velocity.x = chase_direction * chase_speed
	target.move(delta)

func exit():
	pass

func try_transition():
	if transitions.to_wander():
		return get_node("../Wander")
#	if transitions.to_chase():
#		return get_node("../Chase")
	if transitions.to_attack():
		return get_node("../Attack")

func _on_exclamation_timer_timeout():
	exclamation_sprite.hide()
