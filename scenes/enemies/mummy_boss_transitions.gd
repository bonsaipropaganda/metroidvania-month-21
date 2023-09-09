extends Node # TODO make this a class

# node refs
@onready var player_detector = $"../../PlayerDetector"

var target: Node

func to_cool_down() -> bool:
	return false

func to_stomp() -> bool:
	return true

func to_shoot() -> bool:
	return false
