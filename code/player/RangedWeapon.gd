extends Sprite2D
@onready var projectile = preload("res://scenes/util/projectile.tscn")
const OFFSET_X = 15

func use():
	var timer = get_node("../../../Timers/AttackDurationTimer")
	visible = true
	
	var p = projectile.instantiate()
	p.speed = 300
	p.direction.x = get_node("../../..").facing
	p.add_to_group("player_attack")
	get_tree().root.add_child(p)
	p.global_position = Vector2(global_position.x + OFFSET_X * p.direction.x, global_position.y)
	
	timer.start(0.2)
	await timer.timeout
	
	visible = false
