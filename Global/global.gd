extends Node

# used to keep track of which room the player is in
var current_room
signal room_changed(room)

var player_health = 3

func get_player():
	return get_tree().get_nodes_in_group("player").pop_back()

func get_cam():
	return get_tree().get_nodes_in_group("camera").pop_back()
