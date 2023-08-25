extends Node

# used to keep track of which room the player is in
var current_room
signal room_changed(room)

var player_health = 3
