extends CharacterBody2D





func _on_damage_hurtbox_damage_received(amount, damage_source):
	queue_free()
