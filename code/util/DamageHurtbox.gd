extends Area2D
class_name DamageHurtbox
signal damage_received(amount, damage_source)

# invincibility timer
@export var i_seconds = .2
var i_timer = Timer.new()

@export var hit_disable_time = 0.25

func _ready():
	i_timer.one_shot = true
	add_child(i_timer)

func do_iframes():
	i_timer.start(i_seconds)
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	
	await i_timer.timeout
	
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

func _on_DamageHitbox_entered(amount, damage_source):
	if i_timer.time_left == 0 and i_timer.is_stopped():
		# Pass the signal on (to the parent/logic system)
		emit_signal("damage_received", amount, damage_source)
