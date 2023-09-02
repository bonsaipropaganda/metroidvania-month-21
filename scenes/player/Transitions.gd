extends Node # TODO make this a class

var target: Node
@onready var player = $"../.."

func to_jump() -> bool:
	return (Input.is_action_just_pressed("jump") or target.get_node("Timers/BufferJumpTimer").time_left > 0)\
	 			and target.get_node("Timers/CoyoteTimer").time_left > 0

func to_grapple() -> bool:
	var col = target.get_node("GrappleVector").is_colliding()
	return Input.is_action_just_pressed("grapple") and col and player.has_grapple
