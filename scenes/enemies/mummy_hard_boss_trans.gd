extends Node # TODO make this a class

# node refs

var target: Node
var cool_down:= false
var stomp:= false
var shoot:= false

func to_cool_down() -> bool:
	return cool_down

func to_stomp() -> bool:
	return stomp

func to_shoot() -> bool:
	return shoot
