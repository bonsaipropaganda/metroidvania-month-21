extends Node

# node refs
@onready var melee_panel = $HBoxContainer/MeleePanel
@onready var ranged_panel = $HBoxContainer/RangedPanel
@onready var grapple_panel = $HBoxContainer/GrapplePanel
@onready var tnt_panel = $HBoxContainer/TNTPanel
@onready var tnt_amount_label = $HBoxContainer/TNTPanel/AmoutOfTNT

@onready var player = Global.get_player()

func _ready():
	Global.weapons_updated.connect(update_ui_display)
	update_ui_display(player.has_melee,player.has_ranged,player.has_grapple,player.has_tnt)

func update_ui_display(has_melee,has_ranged,has_grapple,has_tnt):
	if has_melee:
		melee_panel.show()
	else: melee_panel.hide()
	if has_ranged:
		ranged_panel.show()
	else: ranged_panel.hide()
	if has_grapple:
		grapple_panel.show()
	else: grapple_panel.hide()
	if has_tnt:
		tnt_panel.show()
	else: tnt_panel.hide()

func update_tnt_amount(amount):
	tnt_amount_label.text = amount
