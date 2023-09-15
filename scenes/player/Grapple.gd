extends State

const DEFAULT_ROPE_LENGTH = 64
const MAX_LENGTH = 160
var rope_length = DEFAULT_ROPE_LENGTH

var point = preload("res://scenes/player/grapple_point.tscn")
var point_instance

func enter():
	SfxManager.pickup.play()
	target.get_node("Sprite").play("default")
	point_instance = point.instantiate()
	var g = target.get_node("GrappleVector")
	rope_length = min(DEFAULT_ROPE_LENGTH, (target.global_position - g.get_collision_point()).length())
	
	if g.get_collider():
		g.get_collider().add_child(point_instance)
		point_instance.global_position = g.get_collision_point()
	else: # Should not come here but I'm being safe
		get_tree().root.add_child(point_instance)
		point_instance.global_position.y = target.global_position.y - DEFAULT_ROPE_LENGTH
		point_instance.global_position.x = target.global_position.x + target.accel.x * 1.7

func update(delta):
	var g = Global.get_grapple_point()
	var diff : Vector2 = target.global_position - g.global_position
	var direction = int(Input.get_axis("left", "right"))
	target.accel = Vector2(target.apply_move_input(direction)*2, target.gravity)
	
	if Input.is_action_pressed("up"):
		rope_length = clamp(rope_length - 80 * delta, 0, DEFAULT_ROPE_LENGTH + 16)
	if Input.is_action_pressed("down"):
		rope_length = clamp(rope_length + 80 * delta, 0, DEFAULT_ROPE_LENGTH + 16)
	
	var distance_ratio = (rope_length - diff.length()) / diff.length()
	
	if distance_ratio < 0:
		target.accel += diff * distance_ratio * 50
	
	target.velocity += target.accel * delta
	
	target.velocity.y *= 0.95 # debounce
	# Drag - TODO commonize this
	if direction == 0:
		if target.is_on_floor():
			target.velocity.x *= target.FLOOR_DRAG
		else:
			target.velocity.x *= target.AIR_DRAG
	target.move_and_slide()

func exit():
	point_instance.queue_free()

func try_transition():
	if Input.is_action_just_pressed("jump"):
		return get_node("../Jump")
	if Input.is_action_just_pressed("grapple")\
		or (point_instance.global_position - target.global_position).length() > MAX_LENGTH:
		return get_node("../Fall")
