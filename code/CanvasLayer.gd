extends CanvasLayer

# node refs
@onready var inventory = $Inventory
@onready var ammo_ui = $Ammo

func _ready():
	Global.got_ranged.connect(_on_got_ranged)

func _input(event):
	if inventory.is_open and (event.is_action_pressed("toggle_inventory") or event.is_action_pressed("ui_cancel")):
		inventory.close()
	elif !inventory.is_open and event.is_action_pressed("toggle_inventory"):
			inventory.update()
			inventory.open()

func _on_got_ranged():
	ammo_ui.visible = true
