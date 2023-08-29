extends Node # TODO make this a class

# node refs
@onready var player_detector = $"../../PlayerDetector"

var target: Node

func to_wander() -> bool:
	if player_detector.is_colliding():
		# if colliding with something else other than the player wander
		if player_detector.get_collider().name != "Player":
			return true
	if !player_detector.is_colliding():
		return true
	return false

func to_chase() -> bool:
	if player_detector.is_colliding():
		if player_detector.get_collider().name == "Player":
			return true
	return false

func to_attack() -> bool:
	return false
