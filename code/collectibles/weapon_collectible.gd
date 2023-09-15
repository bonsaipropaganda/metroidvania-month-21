extends Node2D

enum weapon_types {Melee,Ranged,Grapple,TNT}
@export var selected_weapon_type: weapon_types

# node refs
@onready var player = Global.get_player()
@onready var melee_sprite = $MeleeSprite
@onready var ranged_sprite = $RangedSprite
@onready var grapple_sprite = $GrappleSprite
@onready var tnt_sprite = $TntSprite

func _ready():
	if selected_weapon_type == weapon_types.Melee:
		melee_sprite.visible = true
	if selected_weapon_type == weapon_types.Ranged:
		ranged_sprite.visible = true
	if selected_weapon_type == weapon_types.Grapple:
		grapple_sprite.visible = true
	if selected_weapon_type == weapon_types.TNT:
		tnt_sprite.visible = true

func _on_body_entered(body):
	if body.name == "Player":
		if selected_weapon_type == weapon_types.Melee:
			player.has_melee = true
		if selected_weapon_type == weapon_types.Ranged:
			player.has_ranged = true
		if selected_weapon_type == weapon_types.Grapple:
			player.has_grapple = true
		if selected_weapon_type == weapon_types.TNT:
			player.has_tnt = true
		SfxManager.pickup.play()
		# at the end no matter what type of weapon it is remove the collectible
		queue_free()
