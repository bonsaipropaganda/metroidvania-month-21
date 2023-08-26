# This state does not let the player move. It is for when you are in dialogue, etc.
extends State

func enter():
	pass

func update(delta):
	target.action_manager()

func exit():
	pass

func try_transition():
	return
