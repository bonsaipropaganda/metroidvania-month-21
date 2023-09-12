@tool
extends Node

# used to keep track of which room the player is in
var current_room
var is_map_ready = false
var player_checkpoint: Vector2

signal room_changed(room)
# one is used for the ui and other is for player's actual health
signal update_health_ui(player_health)
signal update_player_health(new_amount)
signal inventory_updated
signal weapons_updated
signal player_died


func _input(event):
	if Engine.is_editor_hint():
		if event is InputEventMouseButton && event.button_index == 1 && !event.pressed:
			for room in get_tree().get_nodes_in_group("room"):
				room.get_node("CollisionShape2D").position = Vector2.ZERO

func get_player():
	return get_tree().get_nodes_in_group("player").pop_back()

func get_cam():
	return get_tree().get_nodes_in_group("camera").pop_back()

func get_spike_respawner():
	return get_tree().get_nodes_in_group("spike_respawner").pop_back()

func get_my_room(me:Node):
	var p = me.get_parent()
	while (p != null):
		if p.is_in_group("room"):
			return p
		p = p.get_parent()
	return null # Not in a room

func get_grapple_point():
	return get_tree().get_nodes_in_group("grapple_point").pop_back()

func do_freeze_frames(freeze_time : float = 0.075):
	get_tree().paused = true
	await get_tree().create_timer(freeze_time).timeout
	get_tree().paused = false
