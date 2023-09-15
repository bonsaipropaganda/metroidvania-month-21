extends State

@onready var projectile = preload("res://scenes/util/projectile.tscn")
const OFFSET_X = 15
var count

func enter():
	count = 0
	target.get_node("Timer").start(1)
	target.get_node("Sprite2D").frame = 3

func shoot():
	target.get_node("Sprite2D").frame = 2
	var pl = Global.get_player()
	var dir = 0
	if pl:
		dir = sign(pl.global_position.x - target.global_position.x)
	
	count += 1
	var timer = target.get_node("Timer")
	
	var p = projectile.instantiate()
	p.speed = 200
	p.direction.x = dir
	target.facing = dir

	if dir == -1:
		target.get_node("Sprite2D").flip_h = false
	if dir == 1:
		target.get_node("Sprite2D").flip_h = true
	
	get_tree().root.add_child(p)
	p.global_position = Vector2(target.global_position.x, target.global_position.y)
	
	await get_tree().create_timer(0.1).timeout
	target.get_node("Sprite2D").frame = 3

func update(_delta):
	if target.get_node("Timer").time_left == 0:
		if count % 3 == 0:
			target.get_node("Timer").start(1.2)
		else:
			target.get_node("Timer").start(0.2)
		shoot()

func exit():
	pass

func try_transition() -> State:
	if count > 9:
		return get_node("../Idle")
	return null
