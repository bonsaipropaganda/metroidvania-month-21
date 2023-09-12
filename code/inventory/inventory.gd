extends Control

@onready var inventory = preload("res://code/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

signal opened
signal closed

var is_open: bool = false


func update():
	for i in range(slots.size()):
		if i < inventory.items.size():
			slots[i].update(inventory.items[i])
		else:
			slots[i].remove_item()


func open():
	if not get_tree().paused:
		is_open = true
		visible = true
		opened.emit()

func close():
	is_open = false
	visible = false
	closed.emit()

func _ready():
	update()
	close()
	Global.inventory_updated.connect(update)
	Global.player_died.connect(_on_player_died)

func _on_player_died():
	print("player ded")
	inventory.items.clear()
	for i in range(slots.size()):
		slots[i].remove_item()
