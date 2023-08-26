extends Node # TODO make this a class

var target: Node

func to_jump() -> bool:
	return (Input.is_action_just_pressed("jump") or target.get_node("Timers/BufferJumpTimer").time_left > 0)\
	 			and target.get_node("Timers/CoyoteTimer").time_left > 0
