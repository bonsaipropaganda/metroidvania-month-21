extends Sprite2D

# node refs
@onready var animation_player = $"../../../AnimationPlayer"

func use():
	var timer = get_node("../../../Timers/AttackDurationTimer")
	animation_player.play("melee")
	visible = true
	$Hitbox.enable()
	
	timer.start(0.7)
	await timer.timeout

	visible = false
	$Hitbox.disable()
